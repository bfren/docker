# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-03)

Audited `alpine`, then fixed some findings - committed and pushed in each repository. This work was merged on top
of the 2026-11-01 session (audit fixes across the images, the move off `shared-build`) - see this file's git history
for that session's notes.

* `alpine` (branch `v4.0.0`): `bf del old` lists the directory itself instead of a `dir/*` glob, so an empty
  directory no longer gives an error. It deliberately skips hidden files and directories (no `--all`) - backup
  volumes can hold markers like `.stfolder` or `.snapshot` that must never be deleted. A test fails if that changes.
  `SHLVL` is no longer saved by `bf env store`. Removed the unused `use dump.nu` from 16 modules. README warns that
  `/etc/bf/env.d` is readable by every user, so passwords should be files rather than `-e`, and says containers must
  start as root (`/init` is `0500`). Changelog updated. The full suite passes on every Alpine version (3.20 to 3.24),
  after the merge too.
* `pull.sh` in all 19 image repositories is now just `git pull --ff-only` (and the optional checkout). It used to run
  `git reset --hard`, which threw away local work, only to undo the mode changes made by its own `chmod +x` line.
  Instead the top-level helper scripts that were stored as `100644` are now executable (`chmod +x`, shown as mode
  changes in `git diff`), including `index/clone-all.sh`, so the `chmod` line is gone. `index/test.nu` is a module, so
  it is left alone; `overlay/` files get their modes at build time, so they are left alone too.
* `bf string format` is now `$values | format pattern $input` (Nushell built-in, one pass) instead of a regex check
  plus a replace per key, which replaced placeholders inside inserted values. Every caller's template (build,
  wordpress, baikal, caddy-proxy, php) is a plain URL or path, so `format pattern` rejecting stray braces is fine.
  In Nushell `catch` must be on the same line as the closing `}` of `try` - on its own line it is run as a command.
* Unused options such as `handle --debug` and `dump --always` stay - they are for debugging (now in `CLAUDE.md`).

Decisions:

* **Downstream images pin `-dev` bases until release** - the bases are not released yet. Needed by Next 3.
* **The documentation site rebuilds only on pushes to `main` in `index`** - `index` is updated whenever the images
  are, so the image repositories need no workflow of their own to trigger it. Needed by Next 4.

## Next

1. Check the development builds of alpine, wordpress and caddy-proxy pass (postgresql, mariadb, wireguard and debian
   have) - and that alpine images have an empty `/var/cache/apk`, debian images an empty `/var/lib/apt/lists` and no
   `/usr/share/man`.
2. Release in order: alpine → debian → alpine-s6 → debian-s6 → the downstream images (bases first).
3. For each downstream image, replace the `-dev` base pin with the released version - `BASE_VERSION` in
   `generate-dockerfiles.sh` (then re-run it), or in the Dockerfile itself for caddy-proxy, freshrss, ftps,
   nginx-webdav, samba, send and wireguard - and set the changelog date when tagging.
4. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.

## Open questions

* Make `/etc/bf/env.d` readable only by root and a shared group (`0640`) instead of every user? The README now warns
  about it instead.
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub.
* Squash-only merges were checked on docker-nginx only - assumed the same everywhere.
