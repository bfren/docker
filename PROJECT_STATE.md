# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-06)

**Released the whole ecosystem** on the new Alpine revisions (3.21.10, 3.22.8, 3.23.8, 3.24.4) and the rebuilt
bfren-bin images: alpine 4.0.1, debian 6.0.1, alpine-s6 7.0.1, debian-s6 5.0.1, then every downstream image (php,
nginx, node, aspnet, caddy-proxy 2.0.2, clamav, ftps, postgresql, redis, samba, unbound, wireguard, mariadb,
nginx-php, nginx-webdav, baikal, freshrss, wordpress, send). Every release build and `update-readme` passed.
alpine-s6's `ALPINE_REVISION` files had not followed alpine's, so its 3.21-3.24 Dockerfiles pinned base tags alpine
4.0.1 never published - fixed before release.

**bfren-bin images** (busybox, figlet, nushell, unbound) now build with the shared
`index/.github/workflows/build-bin.yml` (see "bfren-bin images" in `templates/README.md`):

* Branch pushes build `-dev` tags; merging into `main` builds the release, creates a GitHub release `v<VERSION>` and
  labels each image with its commit (`org.opencontainers.image.revision`). Release tags are never overwritten.
* Versions stay as build dates (`yymmdd`, `.2`, `.3` for a second release that day) rather than semver - the upstream
  version is in each tag, and only these images pin them, exactly.
* Alpine is pinned to the minor (`3.24`), not a revision - only unbound links dynamically, so only the minor matters.
* All four are at `261106.3`. busybox has no GitHub release: `v261106.3` was deleted by accident, and the tag name
  of a deleted immutable release can't be reused. The images are intact. The stray `261106` releases (no `v`) in
  figlet and unbound were deleted, and the duplicate clones in `~/src/docker/bin-*` removed - the clones are in
  `~/src/<name>`, as in the workspace.

**Conventions now in `CLAUDE.md`:** every image and bin repository has a "release tags" ruleset (`v*` tags can't be
deleted or moved - a broken release gets the next revision); `main` is protected everywhere except `index`, which is
committed to directly; every merged image PR is a release, so only `vX.Y.Z` release branches are ever merged; image
repositories are squash-only (docker-nginx-php changed to match), bin repositories also allow merge commits; base
pins go straight to the version being released, with `-dev` only for major updates across the ecosystem. The `latest`
wording now points to `templates/README.md` instead of repeating it.

**Decided, so not to ask again:** keep Redis 7 (on Alpine 3.21) for now; keep `/etc/bf/env.d` permissions as they
are, with the README warning; leave BuildKit, QEMU and the bin images' `alpine:3.24` on Docker Hub.

**Tooling:** `docker system prune` moved from every generate script into `index/update.sh` (after I ran debian's
script and pruned the local Docker). `/prep-release` now checks the base first, commits the README with the
changelog, and treats the dev build as the test; `/close-session` updates the index README's image versions.

## Next

1. alpine v4.0.2 (PR #187, branch pushed): only a README fix (`3c054ba`, tag examples for 4.0.2 and Alpine 3.24.4).
   Merging it releases 4.0.2, which rebuilds unchanged images - either `/prep-release alpine` and merge it now, or
   leave the branch open until something else needs releasing.
2. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`. The site rebuilds only on pushes to `main` in `index`, as
   `index` is updated whenever the images are.

## Open questions

None.
