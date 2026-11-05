# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-05)

Prepped caddy-proxy v2.0.1 (Caddy 2.11.8 to 2.11.9, which fixes the PHP directory-index regression and FastCGI
security issues): changelog and READMEs done, pushed, dev build passed. Ready to tag.

Alpine v4.0.1 now also has an unpushed commit (`975b1e4`) moving to Alpine 3.21.10, 3.22.8, 3.23.8 and 3.24.4, so
that release is no longer README-only. alpine-s6 v7.0.1 is still README-only.

## Next

1. Tag caddy-proxy v2.0.1 (nothing else needed).
2. Release alpine v4.0.1, then alpine-s6 v7.0.1 (branches pushed, except alpine's `975b1e4`). Push that commit, wait
   for the dev build, then run `/prep-release` on each. alpine's `## [4.0.1]` entry must now cover the Alpine
   revision updates (link to the Alpine release notes), not just the README change. alpine-s6 should be rebuilt on
   the new alpine, so check whether its changelog needs a base-image line. Downstream images then need rebuilding
   for the new base.
3. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
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
* Mirror the BuildKit and QEMU (binfmt) images to Quay.io? Every build job still pulls them from Docker Hub.
* Squash-only merges were checked on docker-nginx only - assumed the same everywhere.
