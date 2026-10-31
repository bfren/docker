# bfren Docker ecosystem

This repository (`index`) is the parent of the ecosystem. Each image is a sibling repository in the same folder
(`../alpine`, `../alpine-s6`, `../nginx`, …), published as `bfren/<name>` on Docker Hub and `quay.io/bfren/<name>`.
`README.md` here is the ecosystem index - keep its versions (Alpine, Debian, BusyBox, Nushell, S6, application
versions) in step with the images.

On a new machine, clone `index` then run `./clone-all.sh` to clone the images alongside it (`--pull` also pulls
clean `main` branches). The image list comes from `docker-index.code-workspace` - add new images there.

## Image dependencies and release order

```plain
alpine ─┬─ debian ─── debian-s6 ─── mariadb
        ├─ php
        └─ alpine-s6 ─┬─ nginx ─┬─ nginx-php ─── baikal, freshrss, wordpress
                      │         └─ nginx-webdav
                      ├─ node ─── send
                      └─ aspnet, caddy-proxy, clamav, ftps, postgresql, redis,
                         samba, unbound, wireguard
```

Release in this order: **alpine → debian → alpine-s6 → debian-s6 → downstream images**.

* `debian` clones the alpine overlay at `ALPINE_BRANCH` (a `vX.Y.Z` tag), so alpine must be tagged first.
* `debian-s6` builds `FROM debian` and clones the alpine-s6 overlay at `ALPINE_BRANCH`, so both must be released first.
* Each image's `generate-dockerfiles.sh` pins its base with `BASE_VERSION`. A `-dev` suffix (e.g. `6.6.0-dev`) means
  "built against an unreleased base" - change it to the released version and re-run `generate-dockerfiles.sh` before
  releasing.

## Changelog

Images with a `CHANGELOG.md` (`../alpine` is the reference) follow [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/).

* One `## [X.Y.Z] - YYYY-MM-DD` section per release, newest first, matching `VERSION`. Until the release is tagged use
  `- Unreleased` instead of the date, and set the date when tagging.
* Build each entry from `git log` and `git diff` since the last `vX.Y.Z` tag - read the diff, not just commit
  messages, which can be vague or out of date.
* Group under `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`, in that order, leaving out empty
  groups. Prefix breaking changes (the reason for a major bump) with `**Breaking:**`.
* Write for people using the image: what changed and how it affects them. Leave out build plumbing that has no effect
  on the published image (CI experiments, cache tests, branch pointers).
* When the base image changes, say which version it moved to and link to its changelog rather than repeating it.
* End with a compare link for each version:
  `[X.Y.Z]: https://github.com/bfren/docker-<name>/compare/vPREVIOUS...vX.Y.Z`.
* To add a changelog to a new image, start it at the version being released, with changes since the last tag.

## Versions

* `VERSION`, `VERSION_MAJOR` and `VERSION_MINOR` in each image repository. `bump.sh` (run from an image directory)
  bumps the revision.
* Every image builds with the reusable workflow `index/.github/workflows/build.yml`, called from one small
  `<image>/.github/workflows/build.yml` that lists its folders, platforms and tags once. `index/templates/README.md` is
  the full guide - read it before changing tags.
  * Branch pushes are development builds: the tests run, `-dev` is added to every tag and `latest` becomes `dev`.
    Never write `-dev` in a tag.
  * Published releases push release images with `BF_PUBLISHING=1`, which removes the tests.
  * Tags can use `${FOLDER}` and version files as variables (`${VERSION}`, `${VERSION_MAJOR}`, `${ALPINE_REVISION}`…).
    The folder named in `default-folder` also gets `default-tags` - only Alpine, Alpine S6, Debian, Debian S6, Nginx
    and PHP have one, so the rest have no `latest` and users choose a version.
  * Callers use `bfren/docker/.github/workflows/build.yml@shared-build` until that branch is merged into `main`.
* Moved so far: `alpine` and `alpine-s6`. The rest still have `dev.yml` and `publish.yml` - move an image by copying
  `index/templates/build.yml` and following "Moving an image to the workflow" in `index/templates/README.md`. Until it
  is moved, keep its `dev.yml` tags the same as `publish.yml` with a `-dev` suffix (`sync_dev_tags.py` has been
  deleted on this branch).
* Major: breaking changes. Minor: new features or behaviour. Revision: fixes, and rebuilds for upstream updates (e.g. a
  new base image or BusyBox version with no behaviour change).

## README conventions

Every image README follows the structure of `../alpine/README.md` (the reference):

1. Title, badges, then `[Docker Hub] - [Quay.io] - [bfren ecosystem]` links
2. Introduction - what it is, what it adds to its base image, when to use it (and when to use something else)
3. Quickstart - a minimal working example
4. Features - emoji bullet list
5. Tags - table of tag patterns with examples, then a supported-versions table where relevant
6. Configuration - environment variables (Variable / Values / Description / Default) and build arguments
7. How It Works (and image-specific sections)
8. Testing, Troubleshooting, FAQs
9. Licence and Copyright - keep the existing years

Rules:

* **Every table is aligned**: each column padded to its longest cell, separator dashes to match. After editing any
  README run `python3 tools/fmt_tables.py apply <README.md>` (from this repository), then `check` - it must report
  `0 table(s) misaligned`.
  * **Exception - the index `README.md`**: its Base Images and Applications tables share the same column widths so they
    line up with each other. Use `--shared` (`python3 tools/fmt_tables.py apply --shared README.md`), which gives tables
    with the same number of columns the same widths and keeps any existing extra padding. When adding a row, keep it in
    alphabetical order and copy the badge and link format of the rows around it.
* **Don't duplicate a parent image's documentation.** Summarise and link to it (Debian links to Alpine for the full guide,
  Debian + S6 to Alpine + S6, nginx-based images to nginx), then document only what is different.
* **Tag examples use the version being released** (from `VERSION`), not the last published one.
* **Never copy facts from another README - check them against the source**, because READMEs drift:

  | Fact                                | Source                                                              |
  | ----------------------------------- | ------------------------------------------------------------------- |
  | Health-check timing                 | `HEALTHCHECK` line in `Dockerfile.esh`                              |
  | Environment variables and defaults  | `ENV` block in `Dockerfile.esh`, and `overlay/etc/bf/init.d/*.nu`   |
  | Published tags and platforms        | `.github/workflows/build.yml`, or `publish.yml` if not yet moved    |
  | Supported OS / application versions | `generate-dockerfiles.sh` and the per-version directories           |
  | Base image and pinned versions      | `generate-dockerfiles.sh` (`BASE_VERSION`, `ALPINE_BRANCH`, …)      |
  | Commands and modules                | `overlay/etc/nu/scripts/<module>/` and `overlay/usr/bin/bf/`        |

* If a claim can't be verified from the code (e.g. a package's behaviour on an older Alpine), say so or leave it out.
* British English, short sentences, hyphens (` - `) rather than em dashes.
* Compose examples use the list syntax for `environment` (`- KEY=value`), without quotes around values.

## Code conventions

* Nushell 0.116+, functional style: small composable functions.
* Run externals through `bf handle` (e.g. `{ ^cmd } | bf handle --code-only`, `--ignore-error`), not raw `complete`.
* Remember that a failing external (non-zero exit) aborts a Nushell script - `pidof`, `grep` etc. exit 1 when they find
  nothing.
* Tests live in `overlay/etc/nu/scripts/tests/*.nu`, exported from `tests/mod.nu`, named `<function>__<behaviour>`.
  `/test` runs them **in parallel in one container**, so each test must be self-contained: use temporary directories,
  never modify shared files (e.g. `/etc/nginx`), and never depend on which processes are running - stub commands on
  `PATH` instead.
* Test with `./test.nu [version]` in each image repository (`./test.nu --all` tests every version); test both ends
  of the supported version range when behaviour depends on the OS version.
