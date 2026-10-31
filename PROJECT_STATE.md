# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-10-31)

Done - all committed and pushed, with green dev builds:

* The 19 downstream images are on major-version branches (e.g. nginx `v9.0.0`), built on the unreleased bases
  (alpine 4.0.0, alpine-s6 7.0.0, debian-s6 5.0.0), each with a `CHANGELOG.md` and updated README tags and versions.
* Every image builds with the shared workflow (`build.yml@shared-build`). Builds push to Quay.io only, the merge job
  copies the finished image to Docker Hub, and a newer push cancels an older run on the same branch.
* The mirror also copies the Caddy builder to `quay.io/bfren-bin/caddy` (public), which caddy-proxy now uses.
* send moved to Send 3.5.0 on Node.js 26; node and wordpress build arm/v7 again; node no longer publishes `latest`.
* `index` tools fixed: `update.sh` never loses work, `clone-all.sh` skips `bin/`, `test.nu` exits 1 on failure and
  removes its containers.

Decisions:

* **Downstream images pin `-dev` bases until release** - the bases are not released yet. Needed by Next 2.
* **Build on Quay.io, copy to Docker Hub once** - per-platform jobs hit Docker Hub's rate limit (429) when many images
  built at once.
* **Newer pushes cancel older runs** - an older caddy-proxy run finished last and overwrote the newer `-dev` images.
* **`update.sh` protects work instead of resetting to match GitHub** - repositories only allow squash merges, so
  released branches are found by comparing their squashed change with `origin/main`.

## Next

1. Release in order: alpine → debian → alpine-s6 → debian-s6 → the downstream images (bases first).
2. For each downstream image, replace the `-dev` base pin with the released version - `BASE_VERSION` in
   `generate-dockerfiles.sh` (then re-run it), or in the Dockerfile itself for caddy-proxy, freshrss, ftps,
   nginx-webdav, samba, send and wireguard - and set the changelog date when tagging.
3. Merge `shared-build` into `main` in `index`, then point the image workflows, `templates/build.yml` and `CLAUDE.md`
   at `@main`.

## Open questions

* Delete `test-read-file.yml` and `container-packages-cleanup.yml`? Nothing uses them - nothing pushes to ghcr.io.
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub.
* `update.sh` stops at the first repository whose `git fetch` fails - skip it and carry on instead?
* Squash-only merges were checked on docker-nginx only - assumed the same everywhere.
* `php*-imap` is not packaged for PHP 8.4 and 8.5 on Alpine 3.24, but is in wordpress's `PHP_EXT` - does it matter?
