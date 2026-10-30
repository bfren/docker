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

## Versions

* `VERSION`, `VERSION_MAJOR` and `VERSION_MINOR` in each image repository. `bump.sh` (run from an image directory)
  bumps the revision.
* Each image's `.github/workflows/dev.yml` pushes the same tags as `publish.yml` with a `-dev` suffix (`latest` becomes
  `dev`). After changing tags in `publish.yml`, run `python3 index/tools/sync_dev_tags.py --apply` from the parent folder.
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
  | Environment variables and defaults  | `ENV` block in `Dockerfile.esh`, and `overlay/etc/bf/init.d/*`      |
  | Published tags and platforms        | `.github/workflows/publish.yml`                                     |
  | Supported OS / application versions | `generate-dockerfiles.sh` and the per-version directories           |
  | Base image and pinned versions      | `generate-dockerfiles.sh` (`BASE_VERSION`, `ALPINE_BRANCH`, …)      |
  | Commands and modules                | `overlay/etc/tjs/scripts/bf/` and `overlay/usr/bin/bf/`             |

* If a claim can't be verified from the code (e.g. a package's behaviour on an older Alpine), say so or leave it out.
* British English, short sentences, hyphens (` - `) rather than em dashes.
* Compose examples use the list syntax for `environment` (`- KEY=value`), without quotes around values.

## Code conventions

Images are being migrated from Nushell to [txiki.js](https://github.com/saghul/txiki.js) - `alpine` is done; the
Nushell originals (in `../docker`) are the specification, and `python3 tools/parity.py ../docker images [image]` reports
what is left to port.

* TypeScript in `overlay/etc/tjs/scripts`, compiled to `.js` alongside it with `tsc -p tsconfig.json` from this
  repository (commit both). Functional style: small composable functions, JSDoc on every export.
* **Only `bf/sys.ts` uses the runtime** (`tjs.*`, `tjs:*`) - everything else, in every image, goes through `bf.sys`, so
  moving to another runtime means rewriting that one file.
* Run externals through `bf.handle([...])` (e.g. `{ codeOnly: true }`, `{ ignoreError: true }`), not `sys.spawn`.
  `bf.write.error()` throws, so use it to stop on failure.
* txiki.js has no `Intl`, so `localeCompare` options are ignored - use `naturalCompare` from `bf/util`.
* Executables are `overlay/usr/bin/bf/<name>.ts` with a `#!/bin/tjsh` shebang; `bf-install` removes the `.ts` and the
  `.js` extension. `tjsh` keeps the caller's environment but values in `/etc/bf/env.d` override it (so
  `BF_DEBUG=1 cmd` has no effect if `env.d` has `BF_DEBUG=0`). `bf-install` runs before `tjsh` is installed, and `/init`
  must store the incoming environment without `env.d` replacing it, so both run with
  `tjs run --import-map /etc/tjs/map.json` instead.
* Tests live in `overlay/etc/tjs/scripts/tests/<module>.ts`: every exported function is a test, named
  `<function>__<behaviour>` after the Nushell test it ports. `/test` runs them **in parallel in one process**, so each
  test must be self-contained: use temporary directories, never modify shared files (e.g. `/etc/nginx`), and never
  depend on which processes are running - stub commands on `PATH` instead. Because the process is shared:
  * change `sys.env` or `console` only synchronously, with `withEnv` / `capture` from `tests/lib/capture.ts`
  * run anything that reads or writes the whole environment, changes the working directory, or needs its own `PATH`
    in a child process with `runScript`
* Test with `./test.nu [version]` in each image repository (`./test.nu --all` tests every version); test both ends
  of the supported version range when behaviour depends on the OS version.
