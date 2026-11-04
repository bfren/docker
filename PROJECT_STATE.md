# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-04)

Updated Caddy in `caddy-proxy` (branch `v2.0.0`) from 2.11.7 to 2.11.8, released 2026-11-04 - committed and pushed.
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
* Development builds pass for alpine (`97e0fd4`), wordpress (`3480bcb`), caddy-proxy (`f5e4288`) and debian
  (`efd3690`). `alpine3.20-4.0.0-dev` and `alpine3.24-4.0.0-dev` have an empty `/var/cache/apk`.
* **The debian dev images are not clean.** `debian12-6.0.0-dev` and `debian13-6.0.0-dev` still have the apt package
  index in `/var/lib/apt/lists` (21M) and a `/usr/share/man`. They contain an old alpine overlay: the build log of
  debian run 41605926267 shows the `git clone --branch v4.0.0` step `CACHED`. The image's `clean.nu` still has the
  `/var/cache/apk/*` default from before alpine `468e864` (which takes the caches from `pkg.nu`), so Debian's
  `pkg.nu` caches are never used. Tagging alpine will not fix this, because the `RUN` line does not change and stays
  cached.
* **Fixed** in `debian` (branch `v6.0.0`, `e8f3c04`) and `debian-s6` (branch `v5.0.0`, `a894889`): `Dockerfile.esh` now
  gets the overlay with `ADD https://github.com/bfren/docker-alpine(-s6).git#${ALPINE_BRANCH}` instead of
  `RUN git clone`. BuildKit looks up the remote commit on every build, so the layer rebuilds when the branch or tag
  moves. Debian keeps `bfren/alpine` as the stage base, because it also copies `ca-certificates.crt` from it, and adds
  the repository at `/tmp/docker-alpine`. debian-s6 uses `scratch`. Dockerfiles regenerated. The debian and
  debian-s6 tests pass on 12 and 13. Local builds of debian 12 and 13 have the new `clean.nu`, an empty
  `/var/lib/apt/lists` and no `/usr/share/man`. There is no changelog entry, because the bug only affected
  development builds.
* The development builds pass: debian run 41901548241, and debian-s6 run 41902194097. The debian-s6 run was started
  by hand after debian finished, so it builds on the new debian image. `ADD` from a git URL works in CI.
  `debian12-6.0.0-dev`, `debian13-6.0.0-dev`, `debian-s6:debian12-5.0.0-dev` and `debian-s6:debian13-5.0.0-dev` all
  have an empty `/var/lib/apt/lists` and no `/usr/share/man`.

Decisions:

* **Downstream images pin `-dev` bases until release** - the bases are not released yet. Needed by Next 2.
* **The documentation site rebuilds only on pushes to `main` in `index`** - `index` is updated whenever the images
  are, so the image repositories need no workflow of their own to trigger it. Needed by Next 3.

## Next

1. Release in order: alpine → debian → alpine-s6 → debian-s6 → the downstream images (bases first).
2. For each downstream image, replace the `-dev` base pin with the released version - `BASE_VERSION` in
   `generate-dockerfiles.sh` (then re-run it), or in the Dockerfile itself for caddy-proxy, freshrss, ftps,
   nginx-webdav, samba, send and wireguard - and set the changelog date when tagging.
3. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.

## Open questions

* Make `/etc/bf/env.d` readable only by root and a shared group (`0640`) instead of every user? The README now warns
  about it instead.
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub.
* Squash-only merges were checked on docker-nginx only - assumed the same everywhere.
