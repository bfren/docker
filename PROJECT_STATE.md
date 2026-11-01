# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-01)

Done:

* Confirmed the move off `shared-build` is finished: nothing references it and the branch is deleted.
* Removed `-imap` from wordpress's `overlay/tmp/PHP_EXT`, with a `Removed` entry in its 8.0.0 changelog - not yet
  committed. WordPress 7.1.4 never uses IMAP: the only call is in its bundled PHPMailer, behind a deprecated
  `$useimap` argument that WordPress never sets. Alpine 3.24 no longer packages it for PHP 8.4 and 8.5 anyway.

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

* Delete `test-read-file.yml` and `container-packages-cleanup.yml`? Nothing uses them - nothing pushes to ghcr.io.
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub.
* Squash-only merges were checked on docker-nginx only - assumed the same everywhere.
