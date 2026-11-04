# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-04)

Updated Caddy in `caddy-proxy` (branch `v2.0.0`) from 2.11.7 to 2.11.8, released 2026-11-04 - not yet committed.
The 2026-11-03 session (the `alpine` audit fixes, `pull.sh`, `bf string format`) is in this file's git history.

* `CADDY_VERSION` changed in the `Dockerfile`, in the `caddy-proxy` README build-argument table and in the `index`
  README Applications table. The `2.11-builder-alpine` builder image and caddy-dns/hetzner 2.0.1 (still the latest)
  are unchanged. Added a line to the 2.0.0 changelog. `./test.nu` passes.
* Checked the 2.11.8 breaking changes against the config `bf-proxy` generates. Only two have any effect: requests
  with an invalid host (e.g. `..`) now get `400`, and `encode` compresses even when the request sends
  `Cache-Control: no-transform`. The generated config already meets the stricter validation (one `expression` per
  matcher, lowercase `tls1.3`). Custom configs in `/sites` were not checked - users could be caught by the stricter
  validation there.
* `fmt_tables.py check` without `--shared` reports 1 misaligned table in the `index` README even before this edit.
  This is expected, because those tables share widths - `check --shared` reports 0.

Decisions:

* **Downstream images pin `-dev` bases until release** - the bases are not released yet. Needed by Next 4.
* **The documentation site rebuilds only on pushes to `main` in `index`** - `index` is updated whenever the images
  are, so the image repositories need no workflow of their own to trigger it. Needed by Next 5.

## Next

1. Commit and push the Caddy 2.11.8 update (`caddy-proxy` and the `index` README).
2. Check the development builds of alpine, wordpress and caddy-proxy pass (postgresql, mariadb, wireguard and debian
   have) - and that alpine images have an empty `/var/cache/apk`, debian images an empty `/var/lib/apt/lists` and no
   `/usr/share/man`.
3. Release in order: alpine → debian → alpine-s6 → debian-s6 → the downstream images (bases first).
4. For each downstream image, replace the `-dev` base pin with the released version - `BASE_VERSION` in
   `generate-dockerfiles.sh` (then re-run it), or in the Dockerfile itself for caddy-proxy, freshrss, ftps,
   nginx-webdav, samba, send and wireguard - and set the changelog date when tagging.
5. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.

## Open questions

* Make `/etc/bf/env.d` readable only by root and a shared group (`0640`) instead of every user? The README now warns
  about it instead.
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub.
* Squash-only merges were checked on docker-nginx only - assumed the same everywhere.
