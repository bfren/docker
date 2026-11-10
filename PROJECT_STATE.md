# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-10)

**Moved the ecosystem to Nushell 0.117.0** (bfren-bin `nushell` build `261110.2`) and **released every image** in
cascade order, each as a revision: alpine 4.0.2, debian 6.0.2, alpine-s6 7.0.2, debian-s6 5.0.2, php 4.0.2, nginx
9.0.2, node 6.0.2, then every downstream image. All dev builds passed, every repository is back on a clean `main`,
and the index README already lists Nushell 0.117.0.

* 0.117's one breaking change for us: `hide-env` refuses to hide `CURRENT_FILE` and `FILE_PWD`, so `bf-s6 svc launch`
  (which every service calls) would have failed. They were taken out of its hide list - services now see them.
* New 0.117 commands used: `older-than` in `bf del old`, `record where` in `bf env show` and nginx-php's
  `24-php-env.nu`, `record where` / `record each` in caddy-proxy's `bots.nu` and `routes.nu`. These images no longer
  run on Nushell 0.116.
* Also released: the 2026-11-06 audit fixes (mariadb `init.sql` removal and SQL escaping, ftps `nopriv_user` /
  `ssl_tlsv1` removal, baikal download checksum, wireguard `.254`, postgresql and mariadb database-name lists, the
  alpine-s6 timezone fix). baikal's `overlay/tmp/BAIKAL_SHA256` must be updated with `BAIKAL_REVISION`.
* aspnet's README now says 7.0.2 is the last release with .NET 8 and 9 (end of support 2026-11-10).
* The prep-release skill now sorts release notes into Major / Minor (the image), Documentation, Build and Development
  updates, and leaves the version line out (GitHub adds the PR title).
* node 6.0.2's squash commit on `main` has php's release notes - left as it is (`main` and `v*` tags can't be
  rewritten).

**Decisions:**

* Postgres restores keep deleting `/data` (6.0.1 behaviour) with the README advising a backup first. Moving the data to
  `/backup` was tried and reverted: it needs room for a full copy, and a restore stopped part-way when there was none.

## Next

1. Check by hand on the released images (the builds don't cover these):
   * ftps - logins work, and `openssl s_client -tls1 -starttls ftp -connect <host>:21` is refused.
   * mariadb - after the first start, `/tmp/init.sql` is gone and a restart does not recreate it.
   * postgresql - `pg-restore <folder>` works end to end.
   * alpine-s6 - the container is healthy (cron check), and an unknown `BF_TZ` only warns.
2. aspnet's next release drops .NET 8 and 9: remove them from `ASPNET_VERSIONS` in `generate-dockerfiles.sh`, delete
   the `8/` and `9/` folders, and update the README (supported-versions table, Features, the "last release" note) and
   the index README's ASP.NET row.
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
  `mariadb` run script regenerates `/tmp/init.sql` on every restart, before it is removed again. Checked by task 1.
* What TLS versions does vsftpd 3.0.5 on Alpine allow by default, now `ssl_tlsv1` is gone? Checked by task 1.
