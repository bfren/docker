# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-06)

**Audited the ecosystem** (shared alpine / alpine-s6 core, the build workflow, and the data and security images), then
fixed what was agreed. Every fix is committed (signed) on a local release branch made by `bump.sh` - **none are
pushed**, and no `CHANGELOG.md` entries are written yet:

* alpine-s6 `v7.0.2`: `03-tz.nu` warns and keeps the current timezone if `bf tz` fails (it installs tzdata, so it
  needed the network); the cron health check uses `bf-s6 svc is_up cron`. Also has your "Using latest base images".
* mariadb `v10.0.2`: `/tmp/init.sql` is removed once the server is online (it re-ran on every restart, re-granting
  super user after `db-disable-super-user`); passwords, user names and database names are escaped in generated SQL
  (`init quote`, `init quote_name`); `BF_DB_DATABASE` accepts commas and spaces (`db names`).
* postgresql `v6.0.2`: `BF_PG_DATABASE` accepts spaces and commas; the README's Restore section says to back up
  first. Restores still delete `/data`, as in 6.0.1 - see Decisions.
* ftps `v6.0.2`: `nopriv_user` and `ssl_tlsv1=YES` removed from `vsftpd.conf.esh`.
* baikal `v3.0.2`: the download is checked against `overlay/tmp/BAIKAL_SHA256` (GitHub's asset digest for 0.13.0) -
  update it with `BAIKAL_REVISION`, nothing does it automatically.
* wireguard `v5.0.2` (a peer may use `.254`) and aspnet `v7.0.2` (one `$build` for both downloads).
* debian-s6 `v5.0.2` (your branch, `ALPINE_BRANCH` -> `v7.0.2`) is also local and unpushed.

New tests pass in Windows Nushell where they need no stubs; nothing was built in Docker (not installed on this machine).

**Decisions:**

* Postgres restores keep deleting `/data` (6.0.1 behaviour) with the README advising a backup first. Moving the data to
  `/backup` was tried and reverted: it needs room for a full copy, and a restore stopped part-way when there was none.
* Application-name default passwords (`BF_PG_APPLICATION`, `BF_DB_APPLICATION`) stay - the images are for self-hosters.
* Already documented, so not changed: WireGuard peers renumbering when one is removed, FTPS / Samba passwords only set
  on first start, `/etc/bf/env.d` permissions.
* nginx's fixed `/etc/nginx/nginx.conf` stays: `/test` skips init, so the baikal, freshrss, wordpress and
  nginx-webdav tests run `nginx -t` against it.
* Send's cleanup needs no guard - Send always names uploads `<days>-<id>`.

## Next

1. Release the local branches, in order: alpine-s6 7.0.2 -> debian-s6 5.0.2 -> mariadb 10.0.2, postgresql 6.0.2,
   ftps 6.0.2, baikal 3.0.2, wireguard 5.0.2, aspnet 7.0.2. For each: push, `/prep-release` (changelog), dev build.
   On the dev builds, also check by hand:
   * ftps - logins work, and `openssl s_client -tls1 -starttls ftp -connect <host>:21` is refused.
   * mariadb - after the first start, `/tmp/init.sql` is gone and a restart does not recreate it.
   * postgresql - `pg-restore <folder>` works end to end.
   * alpine-s6 - the container is healthy (cron check), and an unknown `BF_TZ` only warns.
2. alpine v4.0.2 (PR #187, branch pushed): only a README fix (`3c054ba`). Release it with the batch above, or leave it
   open until something else needs releasing.
3. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.
4. Later, in a postgresql release of its own (tested in a container): a restore regenerates `postgresql.conf` and
   `pg_hba.conf`, losing edits the README says are kept; `pg-dump` stages dumps in `/tmp` on Docker's disk rather than
   in `/backup`; `11-user.nu` creates a Linux account nothing uses; `restore main` runs `conf generate` twice.
5. Delete the leftovers at the workspace root: `../_to_delete`, `../_claude-tmp` and `../resign.nu` (no git history -
   Claude was not allowed to delete them).

## Open questions

* Does `mariadb-install-db` write `mariadb_upgrade_info`? If not, `server_is_not_initialised` stays true and the
  `mariadb` run script regenerates `/tmp/init.sql` on every restart, before it is removed again. Check on the dev build.
* What TLS versions does vsftpd 3.0.5 on Alpine allow by default, now `ssl_tlsv1` is gone? Checked by task 1.
