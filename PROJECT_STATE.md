# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-01, txiki.js port on the `tjs` branches)

Done:

* **debian ported to txiki.js** (`docker-debian`, branch `tjs`, pushed as `ca210a4`, version 7.0.0). It overrides
  only `bf/pkg.ts` (apt-get) and `bf/tz.ts` (hard link, no tzdata clean-up). `bf.clean()` takes its default caches
  from `pkg.CACHES`, added to alpine for this, so debian no longer copies `clean`. It builds with txiki.js 26.11.0 and
  clones the alpine overlay from its `tjs` branch. `tsconfig.json` has `rootDirs` so debian's overrides can import
  alpine's modules when compiling.
* **alpine moved to txiki.js 26.11.0** and its build workflow to `@main` (pushed as `ac0e7b4`).
* **The index `tjs` branch** has `main` merged in (pushed as `5d05044`). `update.sh` was adapted to loop over the
  `images/` submodules, where `.git` is a file.
* **alpine v4.0.0's environment changes ported** (pushed as `65b4878`):
  * `env.applyPerms` runs `chmod -R a+rX,go-w`, so only root can write to `/etc/bf/env.d` (README notes
    `bf.env.set()` must run as root).
  * `del.old` defaults to files.
  * `string.format` checks for unknown placeholders before replacing, so values may contain braces.
  * 7 new tests with the Nushell names. Multi-line values needed no code change: `store` already saves whole values
    and `load` keeps the first line, as in v4.0.0.
* **Alpine and Debian slim are mirrored to `quay.io/bfren-bin`** by `tools/mirror-base-images.sh` (daily workflow in
  `index`, also runnable locally), and the image Dockerfiles pull from there - Docker Hub's pull limit was breaking CI.

Decisions:

* **txiki.js images publish under `-tjs` tags** (`alpine3.24-tjs-5.0.0`, `debian13-tjs-7.0.0`, `trixie-tjs`, `tjs`,
  `tjs-7.0` …) so they cannot overwrite the Nushell images. Needed until the txiki.js images replace them.
* **debian's `ALPINE_BRANCH` is `tjs`** (a branch, not a tag) until the first txiki.js alpine release is tagged.
  Needed by Next 5.
* **The HTTP status tests send 10 requests at a time and retry valid statuses up to three times, pausing 500ms
  between tries** - txiki.js 26.11.0 drops 2-4% of connections in bursts ("closed before established"), which
  26.6.0 did not. The suite takes about 11s instead of 5s.
* **Downstream Nushell images pin `-dev` bases until release** - the bases are not released yet. Needed by Next 8.
* **The documentation site rebuilds only on pushes to `main` in `index`** - `index` is updated whenever the images
  are, so the image repositories need no workflow of their own to trigger it. Needed by Next 9.

## Next

txiki.js port (`tjs` branches):

1. Check debian's first CI build on its `tjs` branch - it is the first one to clone alpine's pushed `tjs` branch.
2. Port alpine v4.0.0's BusyBox change: `busybox --install -s` (symlinks, not hard links) in `Dockerfile.esh`, plus
   its test `install busybox__applets_are_symlinks_not_hard_links`. debian already does this.
3. Decide how `tjsh` should treat the environment (see Open questions) - before alpine-s6, whose init, service and
   health scripts depend on it.
4. Port alpine-s6 (509 lines of Nushell plus 397 of tests: init, S6 services, health, `ch.d`, cron), then debian-s6
   (no overlay of its own), then the downstream images - `python3 tools/parity.py ../docker images <image>` shows
   what is left.
5. Tag the first txiki.js alpine release, then set debian's `ALPINE_BRANCH` to it and regenerate.

Nushell images (`main` / release branches):

6. Check the development builds of postgresql, mariadb and wireguard pass - the new tests (restore errors, refusing to
   export `dump`) and the streamed backups have not been run yet.
7. Release in order: alpine → debian → alpine-s6 → debian-s6 → the downstream images (bases first). The `clean`
   cache-defaults backport (debian dropping its `clean.nu`, alpine's `pkg` exporting `caches`) was handed to a Nushell
   session - check it landed before releasing debian, with `ALPINE_BRANCH` on the alpine tag that includes it.
8. For each downstream image, replace the `-dev` base pin with the released version - `BASE_VERSION` in
   `generate-dockerfiles.sh` (then re-run it), or in the Dockerfile itself for caddy-proxy, freshrss, ftps,
   nginx-webdav, samba, send and wireguard - and set the changelog date when tagging.
9. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.

## Open questions

* **Should `tjsh` let the caller's environment win over `/etc/bf/env.d`?** Now `env.d` wins, so `BF_DEBUG=1 cmd` is
  ignored when `env.d` has `BF_DEBUG=0`. Nushell commands that do not call `bf env load` let the caller win.
* **Report txiki.js 26.11's dropped connections upstream?** Anything making many requests at once may hit them.
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub.
* Squash-only merges were checked on docker-nginx only - assumed the same everywhere.
