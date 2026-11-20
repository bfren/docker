# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-20)

**Released upstream updates as revisions**, every image tagged and back on a clean `main`, and the index README is up
to date:

* PHP 8.3.37, 8.4.28 and 8.5.13: php 4.0.3, nginx-php 10.0.4, then baikal 3.0.4, freshrss 6.0.4 and wordpress 8.0.4
  (wordpress also moves to NinjaFirewall 4.10.1).
* mariadb 10.0.3 (MariaDB 10.11.20, 11.4.14, 11.8.10 and 12.3.4; 13.0 stays at 13.0.2) and send 4.0.3 (Send 3.5.1).
* mariadb's first dev build failed because the `mariadb.sources` files still pointed at the old MariaDB repositories -
  bumping `MARIADB_BUILD` isn't enough, the sources must be regenerated (`generate.sh`) too.

**Found from sessions since 2026-11-10 that weren't closed:**

* aspnet 8.0.0 (2026-11-13) - drops .NET 8 and 9, moves to .NET 10.0.15 and 11.0.0, and turns the daily restart off
  by default (`BF_ASPNET_ENABLE_DAILY_RESTART=1` keeps it).
* caddy-proxy 2.0.4 - pinned `$schema` URL (`schemas.bfren.dev/.../2026-11.json`); `proxy-conf-schema.json` is
  deprecated and goes in 3.0.0.
* ftps 6.0.3 - vsftpd's unprivileged process runs as a dedicated `vsftpd` user, fixing `500 OOPS: setgid` under
  Podman `UserNS=auto`.
* nginx 9.0.3 (nginx 1.30.7), with nginx-php 10.0.3, baikal 3.0.3, freshrss 6.0.3 and wordpress 8.0.3 (2026-11-18).
* index: workflow actions pinned, with Dependabot updating the pins after a seven-day cooldown; the tag builder moved to
  `tools/tags.sh`, tested by `tools/test_tags.sh`.
* The workspace-root leftovers (`../_to_delete`, `../_claude-tmp`, `../resign.nu`) are gone.

**Also:** `/close-session` now checks every image's commits and releases since `PROJECT_STATE.md` was last committed,
so sessions that end without it are still picked up.

**Decisions:**

* Postgres restores keep deleting `/data` (6.0.1 behaviour) with the README advising a backup first. Moving the data to
  `/backup` was tried and reverted: it needs room for a full copy, and a restore stopped part-way when there was none.

## Next

1. Check by hand on the released images (the builds don't cover these):
   * ftps 6.0.3 - logins work (including under Podman `UserNS=auto`), and
     `openssl s_client -tls1 -starttls ftp -connect <host>:21` is refused.
   * mariadb - after the first start, `/tmp/init.sql` is gone and a restart does not recreate it.
   * postgresql - `pg-restore <folder>` works end to end.
   * alpine-s6 - the container is healthy (cron check), and an unknown `BF_TZ` only warns.
2. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.
3. Later, in a postgresql release of its own (tested in a container): a restore regenerates `postgresql.conf` and
   `pg_hba.conf`, losing edits the README says are kept; `pg-dump` stages dumps in `/tmp` on Docker's disk rather than
   in `/backup`; `11-user.nu` creates a Linux account nothing uses; `restore main` runs `conf generate` twice.
4. caddy-proxy 3.0.0: remove `proxy-conf-schema.json` (deprecated in 2.0.4).

## Open questions

* Does `mariadb-install-db` write `mariadb_upgrade_info`? If not, `server_is_not_initialised` stays true and the
  `mariadb` run script regenerates `/tmp/init.sql` on every restart, before it is removed again. Checked by task 1.
* What TLS versions does vsftpd 3.0.5 on Alpine allow by default, now `ssl_tlsv1` is gone? Checked by task 1.
