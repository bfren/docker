# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-01)

Done:

* Confirmed the move off `shared-build` is finished: nothing references it and the branch is deleted.
* Removed `-imap` from wordpress's `overlay/tmp/PHP_EXT`, with a `Removed` entry in its 8.0.0 changelog. WordPress 7.1.4 never uses IMAP: the only call is in its bundled PHPMailer, behind a deprecated
  `$useimap` argument that WordPress never sets. Alpine 3.24 no longer packages it for PHP 8.4 and 8.5 anyway.
* Audit fixes in `index`: deleted `test-read-file.yml` and `container-packages-cleanup.yml` (nothing pushes to
  ghcr.io); moved `nuget-packages-cleanup.yml` to `bfren/bfren`, with the third-party action pinned to a commit
  because it is given a token that can delete packages; `bump.sh` stops on uncommitted changes; `fmt_tables.py check`
  exits 1 when a table is misaligned and has a self-check (`tools/test_fmt_tables.py`); the mirror's rate-limit
  step can no longer stop the copy.
* Audit fixes in the image repos, on each one's release branch:
  * postgresql: a restore keeps the dump (renamed `dump.sql.restored`) and saves `psql` errors to `dump.sql.log`
    with a warning - `psql` carries on after a failed statement and exits 0, so a bad dump looked like a success.
  * postgresql and mariadb: backups are streamed to the file (`o>`) instead of going through `bf handle`, which held
    the whole dump in memory; exporting a database called `dump` is refused, as `/backup/dump.sql` triggers a restore.
  * wireguard: peer keys and configurations are `0600` - they were world-readable in the bind-mounted `/config`.
  * All 23 images: `peter-evans/dockerhub-description` pinned to a commit (it gets the Docker Hub token) and the
    unneeded Docker Hub login step removed from `update-readme.yml`.
  * alpine and debian: `bf clean` takes its default caches from `bf pkg caches`, so debian's copy of `clean.nu` is
    deleted and debian only overrides `pkg.nu`.
  * wordpress: a plugin only counts as installed if its directory has files - a failed download left an empty one,
    so Ninja Firewall could be silently missing.
  * caddy-proxy: `auth` must be a bool or a list - any other value was treated as `true` (every user).

Decisions:

* **Downstream images pin `-dev` bases until release** - the bases are not released yet. Needed by Next 3.
* **The documentation site rebuilds only on pushes to `main` in `index`** - `index` is updated whenever the images
  are, so the image repositories need no workflow of their own to trigger it. Needed by Next 4.

## Next

1. Check the development builds of postgresql, mariadb, alpine, debian, wordpress and caddy-proxy pass (wireguard
   has) - and that alpine images have an empty `/var/cache/apk`, debian images an empty `/var/lib/apt/lists` and no
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

* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub.
* Squash-only merges were checked on docker-nginx only - assumed the same everywhere.
