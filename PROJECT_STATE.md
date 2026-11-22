# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-22)

**A documentation round across all 23 images**, each on a new revision branch (`bump.sh`), pushed with its release PR
opened by `auto-pr` - nothing is released yet. caddy-proxy 2.0.5 carries on from a cloud session on 2026-11-21 that
rewrote its DNS challenge instructions (bfren/docker-caddy-proxy#20).

* READMEs: instructions are numbered steps with short reasons for anything unusual, tag examples use the new versions,
  and each Tags section links to the changelog for breaking changes. Instructions that failed when followed are fixed:
  the "Building on this image" Dockerfiles in nginx, nginx-php, nginx-webdav and php lacked `BF_IMAGE` / `BF_VERSION`;
  the FreshRSS and WordPress Quickstarts had no database (now MariaDB, passwords in `.env`, FreshRSS waits for it to
  be healthy); send had no Redis volume; MariaDB's password change must run `db-root` before changing the variable.
* Sample compose files: every image whose README has a compose Quickstart has a `docker-compose.yml` identical to it,
  linked from the README (new in 13 images; postgresql, samba and send brought up to date). unbound's Pi-hole examples
  now use Pi-hole v6's `FTLCONF_*` variables (the old ones were ignored), refuse to start without an admin password,
  use caddy-proxy instead of nginx-proxy and pin the backup Unbound to 4.0.2; its two default-settings files, which had
  not parsed since v3.2.0, are repaired. Examples pull `quay.io/bfren/...`.
* index: a Getting Started section in the README, and `build.yml` now checks every `docker-compose*.yml` and
  `compose/*.yml` with `docker compose config --no-interpolate` before building (merged in bfren/docker#4).
* Upstream updates found by the builds, as Alpine had replaced the pinned packages: ClamAV 1.4.7, Node.js 22.23.5,
  24.22.3 and 26.13.1, PostgreSQL 15.20, 16.16, 17.12 and 18.7, nginx package revisions (3.21 `1.26.3-r4`, 3.22 and
  3.23 `1.28.3-r9`), and nginx-webdav's base moved to nginx 9.0.3 (its 9.0.2 base needed a `dav-ext` package Alpine
  had removed).

**Decisions:**

* nginx on Alpine 3.22 is pinned to `1.28.3-r9` although Alpine's armv7 repository still has only `r7` - better to be
  on the latest build. The 3.22 arm/v7 job fails until Alpine catches up; nothing else needs to change.
* Postgres restores keep deleting `/data` (6.0.1 behaviour) with the README advising a backup first. Moving the data to
  `/backup` was tried and reverted: it needs room for a full copy, and a restore stopped part-way when there was none.

## Next

1. nginx 9.0.4: once `https://dl-cdn.alpinelinux.org/alpine/v3.22/main/armv7/APKINDEX.tar.gz` lists
   `nginx` `1.28.3-r9`, re-run the `v9.0.4` build. Every other image's latest branch build has passed.
2. Release the 23 branches by merging their PRs, in release order (alpine, debian, alpine-s6, debian-s6, then the
   rest), with nginx after task 1. The changes are documentation and package updates only, so no base pins move -
   set each changelog date when tagging.
3. Check by hand on the released images (the builds don't cover these):
   * ftps 6.0.3 - logins work (including under Podman `UserNS=auto`), and
     `openssl s_client -tls1 -starttls ftp -connect <host>:21` is refused.
   * mariadb - after the first start, `/tmp/init.sql` is gone and a restart does not recreate it.
   * postgresql - `pg-restore <folder>` works end to end.
   * alpine-s6 - the container is healthy (cron check), and an unknown `BF_TZ` only warns.
   * unbound - the Pi-hole example starts, Pi-hole answers through both Unbound containers, and its admin site works
     behind caddy-proxy (`docker-compose-with-proxy.yml`).
4. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.
5. Later, in a postgresql release of its own (tested in a container): a restore regenerates `postgresql.conf` and
   `pg_hba.conf` (the README now says so), `pg-dump` stages dumps in `/tmp` on Docker's disk rather than in `/backup`,
   `11-user.nu` creates a Linux account nothing uses, and `restore main` runs `conf generate` twice.
6. caddy-proxy 3.0.0: remove `proxy-conf-schema.json` (deprecated in 2.0.4).
7. freshrss has a leftover `v5.0.1` branch on GitHub, from before 6.0.x - delete it if nothing needs it.

## Open questions

* Does `mariadb-install-db` write `mariadb_upgrade_info`? If not, `server_is_not_initialised` stays true and the
  `mariadb` run script regenerates `/tmp/init.sql` on every restart, before it is removed again. Checked by task 3.
* What TLS versions does vsftpd 3.0.5 on Alpine allow by default, now `ssl_tlsv1` is gone? Checked by task 3.
* Does Pi-hole v6 accept the Unbound containers as `FTLCONF_dns_upstreams: ${IP_RANGE}.2;${IP_RANGE}.200`? The format
  matches Pi-hole's documentation but hasn't been run. Checked by task 3.
