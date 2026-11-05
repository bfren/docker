# Project state

The handoff between sessions - see "Project state" in `CLAUDE.md` for how to keep it.

## Last session (2026-11-05)

Fixed `update.sh` (committed and pushed as `417b1d8`):

* Release branches were never deleted ("kept heads/v10.0.0 - not merged") because each has the same name as its
  release tag. `refname:short` then gives `heads/v10.0.0`, which no `git branch` command can find. It now lists
  branches with `refname:lstrip=2`.
* A branch whose branch on GitHub has been deleted ("gone") is now force-deleted even if not merged, and its last
  commit is printed so it can be restored. This covers squash-merged branches and abandoned ones (e.g. a revision
  bump replaced by a minor bump), so the separate squash-merge check was removed. Branches never pushed, or still on
  GitHub, are kept. To abandon a branch, delete it on GitHub (`git push origin --delete <branch>`).

`/close-session` now commits and pushes `PROJECT_STATE.md` itself (only that file, and only when that commit is the
only unpushed one on `main`) - running the skill is the user's explicit request for it, like `/prep-release`'s
changelog push. `CLAUDE.md` ("Project state") says so.

Decisions:

* **The documentation site rebuilds only on pushes to `main` in `index`** - `index` is updated whenever the images
  are, so the image repositories need no workflow of their own to trigger it. Needed by Next 2.

## Next

1. Release alpine v4.0.1, then alpine-s6 v7.0.1 (branches `v4.0.1` / `v7.0.1` pushed, dev builds passed): the only
   change is the README showing Alpine 3.21 as "ended 2026-11-01". Run `/prep-release` on each - it needs to add a
   `## [4.0.1]` / `## [7.0.1]` changelog entry (probably a single "Changed" line), then tag. Downstream images don't
   need rebuilding for a README change.
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
