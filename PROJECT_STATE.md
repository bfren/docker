# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-05)

Released the whole ecosystem on the new bases, in release order:

* Bases: alpine v4.0.0, debian v6.0.0, alpine-s6 v7.0.0, debian-s6 v5.0.0.
* Downstream: aspnet v7.0.0, baikal v3.0.0, caddy-proxy v2.0.0, clamav v6.0.0, freshrss v6.0.0, ftps v6.0.0,
  mariadb v10.0.0, nginx v9.0.0, nginx-php v10.0.0, nginx-webdav v8.0.0, node v6.0.0, php v4.0.0, postgresql v6.0.0,
  redis v8.0.0, samba v4.0.0, send v4.0.0, unbound v4.0.0, wireguard v5.0.0, wordpress v8.0.0. Every image is back on
  a clean `main`, with no `-dev` base pins left.
* Started alpine v4.0.1 and alpine-s6 v7.0.1 (branches pushed, dev builds passed): README only - Alpine 3.21 is
  shown as "ended 2026-11-01" (nginx's README already says so). Neither has a changelog entry for the new version.

Each image was prepared with `/prep-release <image>`. It changed during the session:

* It commits the dated changelog, checks the base is a released version, then **pushes the changelog commit** - only
  when that commit is the only unpushed one and the working tree is clean - and waits for the dev build of that exact
  commit. Running the skill is the user's explicit request for that one push (an exception to the global "never
  push" rule, stated in the skill).
* `PROJECT_STATE.md` is now written once, at the end of a session, by the new `/close-session` skill - writing it
  after every run wasted tokens and left it contradicting itself.

Decisions:

* **The documentation site rebuilds only on pushes to `main` in `index`** - `index` is updated whenever the images
  are, so the image repositories need no workflow of their own to trigger it. Needed by Next 2.

## Next

1. Release alpine v4.0.1, then alpine-s6 v7.0.1: run `/prep-release` on each - it needs to add a `## [4.0.1]` /
   `## [7.0.1]` changelog entry (README change only, so probably a single "Changed" line), then tag. Downstream
   images don't need rebuilding for a README change.
2. Add a workflow to `index` that collects each image repository's `README.md` and builds a simple documentation
   website from them, hosted on GitHub Pages and published by GitHub Actions. It runs on every push to `main` in
   `index`, fetching the READMEs from each image's `main` branch. The image list comes from
   `docker-index.code-workspace`, as for `clone-all.sh`.

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
