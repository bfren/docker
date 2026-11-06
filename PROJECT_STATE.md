# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-06)

**Released the whole ecosystem** on the new Alpine revisions (3.21.10, 3.22.8, 3.23.8, 3.24.4) and the rebuilt
bfren-bin images: alpine 4.0.1, debian 6.0.1, alpine-s6 7.0.1, debian-s6 5.0.1, then every downstream image (php,
nginx, node, aspnet, caddy-proxy 2.0.2, clamav, ftps, postgresql, redis, samba, unbound, wireguard, mariadb,
nginx-php, nginx-webdav, baikal, freshrss, wordpress, send). alpine-s6's `ALPINE_REVISION` files had not followed
alpine's, so its 3.21-3.24 Dockerfiles pinned base tags alpine 4.0.1 never published - fixed before release.

**bfren-bin images** (busybox, figlet, nushell, unbound) now build with the shared
`index/.github/workflows/build-bin.yml` (see "bfren-bin images" in `templates/README.md`):

* Branch pushes build `-dev` tags; merging into `main` builds the release, creates a GitHub release `v<VERSION>` and
  labels each image with its commit (`org.opencontainers.image.revision`). Release tags are never overwritten.
* Versions stay as build dates (`yymmdd`, `.2`, `.3` for a second release that day) rather than semver - the upstream
  version is in each tag, and only these images pin them, exactly.
* Alpine is pinned to the minor (`3.24`), not a revision - only unbound links dynamically, so only the minor matters.
* All four are at `261106.3`. busybox has no GitHub release: `v261106.3` was deleted by accident, and the tag name
  of a deleted immutable release can't be reused. The images are intact.

**Conventions now in `CLAUDE.md`:** every image and bin repository has a "release tags" ruleset (`v*` tags can't be
deleted or moved - a broken release gets the next revision); `main` is protected everywhere except `index`, which is
committed to directly; base pins go straight to the version being released, with `-dev` only for major updates across
the ecosystem.

**Tooling:** `docker system prune` moved from every generate script into `index/update.sh` (after I ran debian's
script and pruned the local Docker). `/prep-release` now checks the base first, commits the README with the
changelog, and treats the dev build as the test; `/close-session` updates the index README's image versions.

## Next

1. alpine v4.0.2 (PR #187, branch pushed): only a README fix (`3c054ba`, tag examples for 4.0.2 and Alpine 3.24.4).
   Decide whether it is worth a release that rebuilds unchanged images - if so, `/prep-release alpine` then merge; if
   not, close the PR (closing without merging doesn't trigger `auto-release`) and keep the README change for the next
   real release.
2. Tidy the duplicate bin clones: this session cloned the bin repos into `~/src/docker/bin-*` (each on the merged
   `release-step` branch), but the workspace and `clone-all.sh` use `~/src/busybox`, `figlet`, `nushell` and `unbound`.
   Delete `~/src/docker/bin-*` - nothing in them is unpushed - and pull the real clones.
3. figlet and unbound each have an old release and tag named `261106` (no `v`), not created by the workflow - delete
   them so the generated notes compare against `v` tags. (busybox's was deleted with its other release.)
4. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`. The site rebuilds only on pushes to `main` in `index`, as
   `index` is updated whenever the images are.

## Open questions

* `CLAUDE.md` ("Versions") says only images with a `default-folder` get `latest` and "the rest have no `latest`".
  Eight images without per-version folders publish `latest` from their plain `tags`: caddy-proxy, freshrss, ftps,
  nginx-webdav, samba, send, unbound and wireguard. Reword `CLAUDE.md` to say so?
* Redis 7 (7.2.11) is built on Alpine 3.21, which ended 2026-11-01. Keep it, drop it in a future major, or add a
  support column to the README saying so?
* Make `/etc/bf/env.d` readable only by root and a shared group (`0640`) instead of every user? The README now warns
  about it instead.
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub - and the
  bin images still build `FROM alpine:3.24` from Docker Hub.
* In every image repository, `auto-release` creates a release (named after the PR title) when *any* PR is merged, and
  a release rebuilds and re-pushes that version's images. A PR that isn't a release (e.g. a README fix) can't be
  merged without one - add a check on the title (e.g. only `vX.Y.Z`)?
* Merge methods: 22 image repositories allow squash only, but docker-nginx-php also allows merge commits and rebase,
  and the four bin repositories allow all three. Make them squash-only too?
