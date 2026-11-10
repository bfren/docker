---
name: prep-release
description: Prepare a bfren image for release - check every commit since the last tag, bring the changelog and README up to date, make sure the base image is a released version (not -dev), and write the release notes. Use for "prep for release", "prepare <image> for release", "get <image> ready to release", /prep-release <image>.
argument-hint: <image> [<image> ...]
---

# Prepare an image for release

Run from `index`. Each argument is a sibling image repository (`../<image>`). Do the images in release order
(`CLAUDE.md` - "Image dependencies and release order"). Don't wait for one image's development build before preparing
the next - watch the builds in the background and check them in the report. An image whose base is earlier in the
same run is blocked (step 1) until that base is tagged.

The only commit this skill makes is the changelog and README (step 3), and the only push is that commit (step 4).
Never commit or push anything else, and never tag or merge - leave other changes in the working tree and say what is
ready. Running this skill is the user's explicit request to push that commit, under the conditions in step 4.

Do only what the steps say. In particular, don't check that pinned images exist (the development build fails if one
doesn't), and don't read other repositories' history - link to their releases instead (step 2).

## 1. Find the range and check the base

```bash
cd ../<image>
git fetch --tags --quiet
git branch --show-current          # should be vX.Y.Z, matching VERSION
cat VERSION VERSION_MAJOR VERSION_MINOR
git tag --sort=-v:refname | head -1 # the previous release, vPREVIOUS
git status -sb                      # uncommitted work - include it, and say it is uncommitted; "ahead" means unpushed
```

A branch can have the same name as a tag (e.g. `v1.0.7`), so use `refs/tags/vPREVIOUS` in the commands below.

Stop and ask if the branch is not `v<VERSION>`, or if `VERSION_MAJOR` / `VERSION_MINOR` don't match `VERSION`. Check
that the bump fits the changes (`CLAUDE.md` - "Versions"): a breaking change needs a major bump.

Then check the base - it must be a released version, never a `-dev` build:

* `BASE_VERSION` and `ALPINE_BRANCH` in `generate-dockerfiles.sh`. Images without one pin the base in the `Dockerfile`
  itself: the `FROM quay.io/bfren/...` line (freshrss, ftps, nginx-webdav, samba, send, wireguard) or
  `ARG BASE_IMAGE=` (caddy-proxy).
* `grep -n -- '-dev' generate-dockerfiles.sh Dockerfile* */Dockerfile 2>/dev/null` must find no base pin.
* `gh release view v<BASE_VERSION> -R bfren/docker-<base>` must find the release.

If the base isn't released, the image is **blocked**: carry on with steps 2 and 3, but don't push (step 4), and test
locally instead (step 5).

## 2. Read every change

```bash
git log --format='%h %s%n%b' refs/tags/vPREVIOUS..HEAD
git diff --stat refs/tags/vPREVIOUS HEAD
git diff refs/tags/vPREVIOUS HEAD -- . ':!*/Dockerfile' ':!.github' ':!VERSION*' ':!CHANGELOG.md'
```

Read the diff, not just the commit messages. The per-version `Dockerfile`s are generated from `Dockerfile.esh` - read
one of them only to confirm the regenerated output. Sort each change into what affects the published image (for the
changelog) and build or development work (for the release notes only).

For a new bfren-bin build (`BUSYBOX_BUILD`, `NU_BUILD`, `FIGLET_BUILD`, `UNBOUND_BUILD`), say which versions it
contains and link to its release (`https://github.com/bfren/<bin>/releases/tag/v<BUILD>`), whose notes list what
changed - don't read the bin repository's sources or history. Do the same for a base image: link to its changelog.

## 3. Changelog and README

Follow `CLAUDE.md` - "Changelog". Check that:

* The top entry is `## [<VERSION>]` and covers every user-facing change from step 2 - add what's missing, and fix
  entries the diff contradicts. Breaking changes start with `**Breaking:**`.
* A base image change names the new version and links to the base's changelog.
* The date is today's (`date +%F`), replacing `Unreleased`.
* The compare link is `[<VERSION>]: https://github.com/bfren/docker-<image>/compare/vPREVIOUS...v<VERSION>`.

Then the README (`CLAUDE.md` - "README conventions"). Check only the facts that step 2 changed, each against its
source (the table there) - not the whole README:

* Tag examples use `<VERSION>`, with any OS or application revision that changed.
* Any pinned version, supported version, environment variable, default, build argument or command that the diff
  changed.

Run `python3 tools/fmt_tables.py apply ../<image>/README.md` and `check` - it must report `0 table(s) misaligned`.

Then commit both together - only these two files, even if others have changes - so the README is in the release.
Don't push yet:

```bash
git commit -m 'Prepping for release' -- CHANGELOG.md README.md
```

If `HEAD` is already an unpushed `Prepping for release` (or older `Prepping CHANGELOG.md for release`) commit from an
earlier run, amend it instead (`git commit --amend --no-edit -- CHANGELOG.md README.md`), so there is still only one.
If neither file has changes, skip the commit and say so.

## 4. Push

Skip this step if the image is blocked (step 1). Otherwise push the commit, so the development build tests the image
you are releasing:

```bash
git status -sb   # must show only "[ahead 1]" - no other unpushed commits, no modified or untracked files
git push
```

Push only when the commit from step 3 is the only unpushed commit and the working tree is clean - `git push` sends
every unpushed commit, and a build without uncommitted changes would test the wrong image. If anything else is
unpushed or uncommitted, don't push: say what is in the way, and that it needs committing and pushing by the user. If
nothing is unpushed, there is nothing to push.

After a push, the push cancels any running build for the branch (`cancel-in-progress`) and starts one for `HEAD`.
Find it (it can take a few seconds to appear) and watch it in the background, then move on - to step 6, or to the
next image:

```bash
gh run list -R bfren/docker-<image> --branch v<VERSION> --commit $(git rev-parse HEAD) --limit 1 --json databaseId,status
gh run watch <databaseId> -R bfren/docker-<image> --exit-status   # in the background
```

## 5. Test

The development build for the current `HEAD` is the test - it runs the image's tests on each native platform, so don't
also run them locally. It must pass, and a build for an earlier commit doesn't count. Check the background watch from
step 4 in the report.

Only when the image is blocked (nothing was pushed, so nothing else tests it), run `./test.nu --all` in the image
repository (just `./test.nu` for an image with no per-version folders) - it must pass.

## 6. Release notes

These become the squash-merge message, so write plain text that reads well without Markdown rendering:

```plain
v<VERSION>

Major updates
* <Verb>ing ...

Minor updates
* <Verb>ing ...

Documentation updates
* <Verb>ing ...

Build updates
* <Verb>ing ...

Development updates
* <Verb>ing ...

Full changelog: https://github.com/bfren/docker-<image>/blob/v<VERSION>/CHANGELOG.md#<anchor>
```

* Sort each change by what it touches:
  * **Major / Minor updates** - the image itself (overlay, scripts, packages, base and bfren-bin versions). Major is
    for breaking changes and the most important ones, Minor for the rest - including internal changes to the image's
    own scripts.
  * **Documentation updates** - the README, comments and other documentation.
  * **Build updates** - workflow files, tags and how the image is built and published.
  * **Development updates** - the development environment: workspace files, build tools and helper scripts.
* Every bullet starts with an `-ing` verb, has no full stop, and is one short line. Leave out empty sections.
* Unlike the changelog, include build and development changes, but not CI experiments, cache tests or branch pointers.
* The anchor is the heading with the brackets and dots removed and spaces turned into hyphens:
  `## [4.0.0] - 2026-11-05` gives `#400---2026-11-05`.

## 7. Report

Wait for any development builds still running, then give each image's release notes in a code block, and list:

* what was changed (files, and what was added to the changelog or README)
* every check that failed or could not be run, and why
* whether the commit was pushed, and if not, why
* what's left before tagging - e.g. the base not released yet, or the dev build failed

Don't update `PROJECT_STATE.md` or the `index` `README.md` - `/close-session` does both once, at the end of the
session.
