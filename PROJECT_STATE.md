# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-10-31)

Done - all committed and pushed:

* `shared-build` is merged into `main` in `index` (PR #1). The image workflows, `templates/build.yml` and `CLAUDE.md`
  still point at `@shared-build`, so keep that branch until they move.
* `update.sh` skips a repository whose `git fetch` fails and carries on, instead of stopping.
* Planned a documentation website built from the image READMEs (Next 4).

Decisions:

* **Downstream images pin `-dev` bases until release** - the bases are not released yet. Needed by Next 3.
* **The documentation site rebuilds only on pushes to `main` in `index`** - `index` is updated whenever the images
  are, so the image repositories need no workflow of their own to trigger it. Needed by Next 4.

## Next

1. Point the image workflows, `templates/build.yml` and `CLAUDE.md` at `build.yml@main`, then delete the
   `shared-build` branch.
2. Release in order: alpine → debian → alpine-s6 → debian-s6 → the downstream images (bases first).
3. For each downstream image, replace the `-dev` base pin with the released version - `BASE_VERSION` in
   `generate-dockerfiles.sh` (then re-run it), or in the Dockerfile itself for caddy-proxy, freshrss, ftps,
   nginx-webdav, samba, send and wireguard - and set the changelog date when tagging.
4. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.

## Open questions

* Delete `test-read-file.yml` and `container-packages-cleanup.yml`? Nothing uses them - nothing pushes to ghcr.io.
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub.
* Squash-only merges were checked on docker-nginx only - assumed the same everywhere.
* `php*-imap` is not packaged for PHP 8.4 and 8.5 on Alpine 3.24, but is in wordpress's `PHP_EXT` - does it matter?
