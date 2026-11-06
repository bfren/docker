---
name: close-session
description: Close a working session - bring the index README's image versions up to date, rewrite PROJECT_STATE.md (the handoff to the next session) from what this session did and decided, then commit and push both. Use for "close the session", "wrap up", "end of session", "update the project state", /close-session.
---

# Close the session

`PROJECT_STATE.md` and the versions in the `index` `README.md` are written once, here, at the end of a session - not
during it. Run from `index`.

## 1. Gather

Work out the current state from this conversation, then check it against the repositories rather than trusting
earlier messages, which may be out of date:

* For each image touched this session: `git -C ../<image> status -sb` (uncommitted or unpushed work), whether its
  release exists (`gh release view v<VERSION> -R bfren/docker-<image>`), and the result of its latest development
  build if it was waiting on one.
* Read the current `PROJECT_STATE.md`: its Next tasks and Open questions carry over unless this session finished or
  answered them.

## 2. Update the index README

For each image released or prepared for release this session, check the versions its row in `README.md` lists (OS,
application, BusyBox, Nushell, S6) against its source (`CLAUDE.md` - "README conventions", the table there), and fix
any that changed. Leave the other rows alone.

Then run `python3 tools/fmt_tables.py apply --shared README.md` and `check` - it must report `0 table(s) misaligned`.
If nothing changed, skip this step.

## 3. Rewrite `PROJECT_STATE.md`

Follow `CLAUDE.md` - "Project state". Write the file once, in its final form:

* **Last session (YYYY-MM-DD)** - replace the section. Say what was done and what was decided, with the reasoning.
  Group images in the same state on one line (e.g. "Released a, b and c", "Ready to tag: d and e") rather than one
  bullet per image, and keep only what the next session needs: commit hashes and build numbers only for work still
  waiting on something.
* **Decisions** - keep one only while an unfinished task depends on it. A lasting convention moves into `CLAUDE.md`.
* **Next** - unfinished tasks in order, with exactly what each still needs.
* **Open questions** - add new ones, remove answered ones. Only claims checked against the code or a command.

Lines wrap at 120 characters.

## 4. Commit and push

Running this skill is the user's explicit request to commit and push `README.md` (if step 2 changed it) and
`PROJECT_STATE.md` - and nothing else. Commit each on its own, only that file, even if others have changes:

```bash
git commit -m "Updating image versions" -- README.md     # only if step 2 changed it
git commit -m "Updating project state" -- PROJECT_STATE.md
git status -sb   # must show only these one or two commits ahead - no other unpushed commits
git push
```

If `git status -sb` shows other unpushed commits, or the branch isn't `main`, don't push - say why and leave it to the
user.

## 5. Hand over

Show the user a short summary of what changed in `PROJECT_STATE.md` and `README.md`, and whether they were pushed. If
`CLAUDE.md` (a convention moved there) or anything else has changes, say they are uncommitted and ask the user to
commit them.
