# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-24)

A cloud session. Its commits are signed with the session's key, so GitHub shows them as unverified - see `CLAUDE.md`.

* freshrss 6.0.5 (`v6.0.5`, `8f09576`): FreshRSS 1.31.0, which needs PHP 8.2+ (the image has 8.5.13) and fixes
  about 20 security advisories. Branch build passed.
* debian 6.0.3 (`v6.0.3`, `21cc178`): Debian 13 moved to 13.8 (`13/DEBIAN_MINOR`, `13/Dockerfile`, README, changelog).
  The mirror workflow already copied `debian:13.8-slim` to Quay.io. Branch build passed.
* nushell: released `v261124` (bfren/nushell#7) - no more bullseye images, and `run.sh` uses the workflow's tags.
* bfren-bin `build-complete` check: PRs open with `VERSION` `261125` - bfren/nushell#8 (build passed), bfren/busybox#5,
  bfren/figlet#3 (build passed) and bfren/unbound#3 (busybox and unbound builds were still running).
* index: the shared image workflow has a `complete` job, which every image reports as `build / complete`
  (bfren/docker#6, merged). No image build has run it yet.
* index README: Debian 13.8 and FreshRSS 1.31.0.

## Next

1. nginx 9.0.4: once `https://dl-cdn.alpinelinux.org/alpine/v3.22/main/armv7/APKINDEX.tar.gz` lists
   `nginx` `1.28.3-r9`, re-run the `v9.0.4` build (not checked this session - the host was blocked).
2. Merge the bfren-bin PRs (nushell#8, busybox#5, figlet#3, unbound#3), once their builds pass - `VERSION` only has
   to be unused, so `261125` still works on a later day. Then in each `main` ruleset replace the required `build (…)`
   checks with `build-complete`. Delete nushell's leftover `claude/signed-bullseye` branch.
3. Release the 23 image branches by merging their PRs, in release order (alpine, debian, alpine-s6, debian-s6, then
   the rest), with nginx after task 1:
   * First re-run each branch's build, so it has a `build / complete` result, and check the first one passes. Only
     then switch the image rulesets to require `build / complete`, or the release PRs wait for a check that never ran.
   * freshrss and debian have unverified commits from this session (`8f09576`, `21cc178`). Squash-merge them, which
     should pass the signed-commit rule (unconfirmed), or re-sign the commit locally first.
   * debian: `13/Dockerfile` was edited by hand, as `generate-dockerfiles.sh` needs Docker Hub - re-run it to confirm
     nothing else changes.
   * The changes are documentation and package updates (plus FreshRSS 1.31.0 and Debian 13.8), so no base pins move -
     set each changelog date when tagging.
4. Check by hand on the released images (the builds don't cover these):
   * ftps 6.0.3 - logins work (including under Podman `UserNS=auto`), and
     `openssl s_client -tls1 -starttls ftp -connect <host>:21` is refused.
   * mariadb - after the first start, `/tmp/init.sql` is gone and a restart does not recreate it.
   * postgresql - `pg-restore <folder>` works end to end.
   * alpine-s6 - the container is healthy (cron check), and an unknown `BF_TZ` only warns.
   * unbound - the Pi-hole example starts, Pi-hole answers through both Unbound containers, and its admin site works
     behind caddy-proxy (`docker-compose-with-proxy.yml`).
   * freshrss 6.0.5 - logging in works (FreshRSS 1.31.0 replaced its bcrypt challenge login).
5. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.
6. Later, in a postgresql release of its own (tested in a container): a restore regenerates `postgresql.conf` and
   `pg_hba.conf` (the README now says so), `pg-dump` stages dumps in `/tmp` on Docker's disk rather than in `/backup`,
   `11-user.nu` creates a Linux account nothing uses, and `restore main` runs `conf generate` twice.
7. caddy-proxy 3.0.0: remove `proxy-conf-schema.json` (deprecated in 2.0.4).
8. freshrss has a leftover `v5.0.1` branch on GitHub, from before 6.0.x - delete it if nothing needs it.

## Open questions

* Does `mariadb-install-db` write `mariadb_upgrade_info`? If not, `server_is_not_initialised` stays true and the
  `mariadb` run script regenerates `/tmp/init.sql` on every restart, before it is removed again. Checked by task 4.
* What TLS versions does vsftpd 3.0.5 on Alpine allow by default, now `ssl_tlsv1` is gone? Checked by task 4.
* Does Pi-hole v6 accept the Unbound containers as `FTLCONF_dns_upstreams: ${IP_RANGE}.2;${IP_RANGE}.200`? The format
  matches Pi-hole's documentation but hasn't been run. Checked by task 4.
* Does the image repositories' signed-commit rule allow a squash merge of a PR with unverified commits? Checked by
  task 3.
