# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-25)

* Released all 23 images, in release order, and every release build passed: alpine 4.0.3, debian 6.0.3,
  alpine-s6 7.0.3, debian-s6 5.0.3 and 5.0.4, php 4.0.4, node 6.0.3, nginx 9.0.4, nginx-php 10.0.5, nginx-webdav
  8.0.3, baikal 3.0.5, freshrss 6.0.5, wordpress 8.0.5, aspnet 8.0.1, caddy-proxy 2.0.5, clamav 6.0.3, ftps 6.0.4,
  mariadb 10.1.0, postgresql 6.0.3, redis 8.0.3, samba 4.0.3, send 4.0.4, unbound 4.0.3 and wireguard 5.0.3.
* nginx 9.0.4 has its own `bf pkg install` (`overlay/etc/nu/scripts/bf/pkg.nu`), which falls back from
  `nginx=1.28.3-r9` to `nginx~1.28.3` when an architecture doesn't have the pinned build yet (armv7 had `-r7`).
* mariadb 10.1.0 adds MariaDB 13.1.2 and 13.2.1. freshrss and wordpress compose examples now use `mariadb11.8-10.1`.
* The alpine, alpine-s6, debian and debian-s6 rulesets require `build / complete`, as do the bfren-bin `main` rulesets
  (`build-complete`). Merged the bfren-bin `build-complete` PRs (all released as `v261125`) and deleted nushell's
  `claude/signed-bullseye` branch.
* index: the image template workflow and the bfren-bin example are named `publish`; README has MariaDB 13.1.2 and
  13.2.1.
* Squash-merging a PR with unverified commits (freshrss, debian) passed the signed-commit rule - the squash commits are
  verified.

## Next

1. Switch the other 19 image rulesets (aspnet onwards) from the `build / merge (…)` checks to `build / complete` -
   every release build today ran the `complete` job.
2. alpine 4.0.4 (`v4.0.4`, PR #189, build passed): adds `bf pkg install --fallback-revision` and `bf pkg installed`
   (`1a6cb17`), the same fallback nginx carries in its own `pkg.nu`. That is a new feature, so probably 4.1.0 - bump,
   then `/prep-release alpine` (no changelog entry yet). Once released, nginx's copy can go in favour of
   `--fallback-revision`.
3. bfren-bin `rename-workflow` branches (busybox, figlet, nushell, unbound) rename the workflow to `publish`. Their
   `VERSION` is still `261125`, which is released, so set an unused one before merging. figlet and unbound also have
   leftover `build-on-push` branches (PR #1, merged) to delete.
4. Rename each image's `.github/workflows/build.yml` from `name: build` to `name: publish`, to match
   `templates/build.yml` - on each image's next release branch, not a release of its own.
5. Check by hand on the released images (the builds don't cover these):
   * ftps 6.0.4 - logins work (including under Podman `UserNS=auto`), and
     `openssl s_client -tls1 -starttls ftp -connect <host>:21` is refused.
   * mariadb - after the first start, `/tmp/init.sql` is gone and a restart does not recreate it.
   * postgresql - `pg-restore <folder>` works end to end.
   * alpine-s6 - the container is healthy (cron check), and an unknown `BF_TZ` only warns.
   * unbound - the Pi-hole example starts, Pi-hole answers through both Unbound containers, and its admin site works
     behind caddy-proxy (`docker-compose-with-proxy.yml`).
   * freshrss 6.0.5 - logging in works (FreshRSS 1.31.0 replaced its bcrypt challenge login).
6. Open `tjs` PRs in alpine (#184), debian (#125) and alpine-s6 (#220) - not looked at this session.
7. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.
8. Later, in a postgresql release of its own (tested in a container): a restore regenerates `postgresql.conf` and
   `pg_hba.conf` (the README now says so), `pg-dump` stages dumps in `/tmp` on Docker's disk rather than in `/backup`,
   `11-user.nu` creates a Linux account nothing uses, and `restore main` runs `conf generate` twice.
9. caddy-proxy 3.0.0: remove `proxy-conf-schema.json` (deprecated in 2.0.4).
10. freshrss has a leftover `v5.0.1` branch on GitHub, from before 6.0.x - delete it if nothing needs it.
11. mariadb: `test.nu` and the README's testing line still default to 13.0 - optionally move to the newest version on
    the next release branch.

## Open questions

* Does `mariadb-install-db` write `mariadb_upgrade_info`? If not, `server_is_not_initialised` stays true and the
  `mariadb` run script regenerates `/tmp/init.sql` on every restart, before it is removed again. Checked by task 5.
* What TLS versions does vsftpd 3.0.5 on Alpine allow by default, now `ssl_tlsv1` is gone? Checked by task 5.
* Does Pi-hole v6 accept the Unbound containers as `FTLCONF_dns_upstreams: ${IP_RANGE}.2;${IP_RANGE}.200`? The format
  matches Pi-hole's documentation but hasn't been run. Checked by task 5.
