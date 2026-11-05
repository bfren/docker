---
name: prep-release
description: Prepare a bfren image for release - check every commit since the last tag, bring the changelog and README up to date, make sure the base image is a released version (not -dev), and write the release notes. Use for "prep for release", "prepare <image> for release", "get <image> ready to release", /prep-release <image>.
argument-hint: <image> [<image> ...]
---

# Prepare an image for release

Run from `index`. Each argument is a sibling image repository (`../<image>`). Do the images in release order
(`CLAUDE.md` - "Image dependencies and release order"), and finish one before starting the next.

The only commit this skill makes is the changelog (step 3), and the only push is that commit (step 4). Never commit or
push anything else, and never tag or merge - leave other changes in the working tree and say what is ready. Running
this skill is the user's explicit request to push the changelog commit, under the conditions in step 4.

## 1. Find the range

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

## 2. Read every change

```bash
git log --format='%h %s%n%b' refs/tags/vPREVIOUS..HEAD
git diff --stat refs/tags/vPREVIOUS HEAD
git diff refs/tags/vPREVIOUS HEAD -- . ':!*/Dockerfile' ':!.github' ':!VERSION*' ':!CHANGELOG.md'
```

Read the diff, not just the commit messages. The per-version `Dockerfile`s are generated from `Dockerfile.esh` - read
one of them only to confirm the regenerated output. Sort each change into what affects the published image (for the
changelog) and build or development work (for the release notes only).

## 3. Changelog

Follow `CLAUDE.md` - "Changelog". Check that:

* The top entry is `## [<VERSION>]` and covers every user-facing change from step 2 - add what's missing, and fix
  entries the diff contradicts. Breaking changes start with `**Breaking:**`.
* A base image change names the new version and links to the base's changelog.
* The date is today's (`date +%F`), replacing `Unreleased`.
* The compare link is `[<VERSION>]: https://github.com/bfren/docker-<image>/compare/vPREVIOUS...v<VERSION>`.

Then commit the changelog on its own - only `CHANGELOG.md`, even if other files have changes. Don't push yet - that
waits for the base check in step 4:

```bash
git commit -m 'Prepping CHANGELOG.md for release' -- CHANGELOG.md
```

If `HEAD` is already an unpushed `Prepping CHANGELOG.md for release` commit from an earlier run, amend it instead
(`git commit --amend --no-edit -- CHANGELOG.md`), so there is still only one. If `CHANGELOG.md` has no changes (already
dated and complete), skip the commit and say so.

## 4. Check the base image

The base must be a released version, never a `-dev` build.

* `BASE_VERSION` and `ALPINE_BRANCH` in `generate-dockerfiles.sh`. Images without one pin the base in the `Dockerfile`
  itself: the `FROM quay.io/bfren/...` line (freshrss, ftps, nginx-webdav, samba, send, wireguard) or
  `ARG BASE_IMAGE=` (caddy-proxy).
* `grep -n -- '-dev' generate-dockerfiles.sh Dockerfile* */Dockerfile 2>/dev/null` must find no base pin.
* The base version must be released: `gh release view v<BASE_VERSION> -R bfren/docker-<base>`. If it isn't, stop -
  the base is released first. Don't push.
* If a pin changes, re-run `./generate-dockerfiles.sh` and check that the generated `Dockerfile`s changed to match. If
  the changelog's base version was wrong, fix it and amend the changelog commit (it isn't pushed yet).

Then push the changelog commit - only now, after the base check, so the build tests the image you are releasing:

```bash
git status -sb   # must show only "[ahead 1]" - no other unpushed commits, no modified or untracked files
git push
```

Push only when the changelog commit is the only unpushed commit and the working tree is clean - `git push` sends every
unpushed commit, and a build without uncommitted changes (e.g. a base pin changed above) would test the wrong image. If
anything else is unpushed or uncommitted, don't push: say what is in the way, and that it needs committing and pushing
by the user. The changelog commit can be from this run or an earlier one - push it either way. If nothing is
unpushed, there is nothing to push.

After a push, start waiting for the development build in the background (see step 6) and carry on with step 5.

## 5. README

Follow `CLAUDE.md` - "README conventions", checking each fact against its source (the table there). Look in particular
for what step 2 changed:

* Tag examples use `<VERSION>`, and the supported-versions table matches the per-version directories.
* Environment variables, defaults, build arguments and commands match the code.
* Pinned versions (base, BusyBox, Nushell, S6, application) match `generate-dockerfiles.sh` or the `Dockerfile`.

Then run `python3 tools/fmt_tables.py apply ../<image>/README.md` and `check` - it must report `0 table(s)
misaligned`. Also update the `index` `README.md` if any version it lists for this image changed (`--shared`).

## 6. Test

* `./test.nu --all` in the image repository (just `./test.nu` for an image with no per-version folders) - it must
  pass.
* The development build for the current `HEAD` must pass - a build for an earlier commit doesn't count. If step 4
  pushed, the push cancels any running build for the branch (`cancel-in-progress`) and starts one for `HEAD`. Find it
  (it can take a few seconds to appear) and wait for it:

  ```bash
  gh run list -R bfren/docker-<image> --branch v<VERSION> --commit $(git rev-parse HEAD) --limit 1 --json databaseId,status
  gh run watch <databaseId> -R bfren/docker-<image> --exit-status
  ```

  The watch was started in the background in step 4 - check its result here. If `HEAD` was not pushed (step 4
  stopped), say so - it needs pushing and a passing build before tagging.

## 7. Release notes

These become the squash-merge message, so write plain text that reads well without Markdown rendering. Use the style of
the earlier releases (e.g. `git log -1 --format=%B v3.5.0` in `../alpine`):

```plain
v<VERSION>

Major updates
* <Verb>ing ... (breaking changes and the most important ones)

Minor updates
* <Verb>ing ...

Build updates
* <Verb>ing ...

Development updates
* <Verb>ing ...

Full changelog: https://github.com/bfren/docker-<image>/blob/v<VERSION>/CHANGELOG.md#<anchor>
```

* Every bullet starts with an `-ing` verb, has no full stop, and is one short line. Leave out empty sections.
* Unlike the changelog, include build and development changes, but not CI experiments, cache tests or branch pointers.
* The anchor is the heading with the brackets and dots removed and spaces turned into hyphens:
  `## [4.0.0] - 2026-11-05` gives `#400---2026-11-05`.

## 8. Report

Give the release notes in a code block, then list:

* what was changed (files, and what was added to the changelog or README)
* every check that failed or could not be run, and why
* whether the changelog commit was pushed, and if not, why
* what's left before tagging - e.g. the base not released yet, or the dev build failed

Then update `PROJECT_STATE.md` as `CLAUDE.md` - "Project state" says.
