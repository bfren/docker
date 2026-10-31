# Project state

Snapshot of the ecosystem - see "Project state" in `CLAUDE.md` for how to keep it. Last updated 2026-10-31.

## What's built

* **Every image is on a major-version branch**, pushed, with green dev builds: alpine 4.0.0, debian 6.0.0, alpine-s6
  7.0.0, debian-s6 5.0.0, then aspnet 7.0.0, baikal 3.0.0, caddy-proxy 2.0.0, clamav 6.0.0, freshrss 6.0.0, ftps 6.0.0,
  mariadb 10.0.0, nginx 9.0.0, nginx-php 10.0.0, nginx-webdav 8.0.0, node 6.0.0, php 4.0.0, postgresql 6.0.0, redis
  8.0.0, samba 4.0.0, send 4.0.0 (Send 3.5.0 on Node.js 26), unbound 4.0.0, wireguard 5.0.0, wordpress 8.0.0.
* **Each has a `CHANGELOG.md`** with an `Unreleased` entry, and README tag examples and application versions for the
  new version. Supported Alpine is 3.20 to 3.24.
* **Every image uses the shared build workflow** (`index/.github/workflows/build.yml@shared-build`): per-platform
  builds push to Quay.io only, the merge job builds the multi-platform image on Quay.io and copies it to Docker Hub,
  and a newer push cancels an older run on the same branch.
* **`mirror-base-images.yml`** (via `tools/mirror-base-images.sh`) copies Alpine, Debian slim and the Caddy builder
  (`quay.io/bfren-bin/caddy:2.11-builder-alpine`, public) from Docker Hub to Quay.io.
* **Local tools**: `test.nu` exits 1 on failure and removes its containers; `update.sh` never loses work (skips dirty
  repositories, deletes only merged or squash-merged branches, fast-forward pulls); `clone-all.sh` skips `bin/`.

## Key decisions

* **Downstream images pin `-dev` bases until release** - the bases are unreleased. Swap each pin for the released
  version when releasing, not before.
* **Build on Quay.io, copy to Docker Hub once** - per-platform jobs hit Docker Hub's rate limit (429) when many images
  built at once. Docker Hub now sees one copy per folder.
* **`default-folder` (a `latest` tag) only for** Alpine, Alpine S6, Debian, Debian S6, Nginx, PHP, ClamAV and Redis,
  plus Baïkal for its `baikalA.B.C` tags. Node dropped `latest` in 6.0.0 - users choose a Node.js version.
* **Changelogs leave out build plumbing** with no effect on the image (e.g. test-list cleanups), per the rules in
  `CLAUDE.md`.
* **`update.sh` protects unpushed and uncommitted work** rather than resetting to match GitHub - repositories only
  allow squash merges, so released branches are found by comparing their squashed change with `origin/main`.
* **arm/v7 is built for node and wordpress again** - their Alpine packages exist for armv7.

## What's next

1. Release in order: alpine → debian → alpine-s6 → debian-s6 → downstream (bases before the images built on them).
2. For each downstream image: replace the `-dev` base pin with the released version - `BASE_VERSION` in
   `generate-dockerfiles.sh` (then re-run it), or directly in the Dockerfile for caddy-proxy, freshrss, ftps,
   nginx-webdav, samba, send and wireguard. Set the changelog date when tagging.
3. Merge `shared-build` into `main` in `index`, then point the 23 image workflows, `templates/build.yml` and
   `CLAUDE.md` at `@main`.

## Open questions

* Delete `test-read-file.yml` and `container-packages-cleanup.yml`? Nothing uses them - nothing pushes to ghcr.io.
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io too? Every build job still pulls them from Docker Hub
  anonymously.
* `update.sh` stops at the first repository whose `git fetch` fails - skip it and carry on instead?
* Merge settings (squash only) were checked on docker-nginx only - assumed the same everywhere.
* `php*-imap` is not packaged for PHP 8.4 and 8.5 on Alpine 3.24, but is in wordpress's `PHP_EXT` - does it matter?
