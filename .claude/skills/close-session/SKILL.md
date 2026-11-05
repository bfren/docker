---
name: close-session
description: Close a working session - rewrite PROJECT_STATE.md (the handoff to the next session) from what this session did and decided, then ask the user to commit and push index. Use for "close the session", "wrap up", "end of session", "update the project state", /close-session.
---

# Close the session

`PROJECT_STATE.md` is written once, here, at the end of a session - not during it. Run from `index`.

## 1. Gather

Work out the current state from this conversation, then check it against the repositories rather than trusting
earlier messages, which may be out of date:

* For each image touched this session: `git -C ../<image> status -sb` (uncommitted or unpushed work), whether its
  release exists (`gh release view v<VERSION> -R bfren/docker-<image>`), and the result of its latest development
  build if it was waiting on one.
* Read the current `PROJECT_STATE.md`: its Next tasks and Open questions carry over unless this session finished or
  answered them.

## 2. Rewrite `PROJECT_STATE.md`

Follow `CLAUDE.md` - "Project state". Write the file once, in its final form:

* **Last session (YYYY-MM-DD)** - replace the section. Say what was done and what was decided, with the reasoning.
  Group images in the same state on one line (e.g. "Released a, b and c", "Ready to tag: d and e") rather than one
  bullet per image, and keep only what the next session needs: commit hashes and build numbers only for work still
  waiting on something.
* **Decisions** - keep one only while an unfinished task depends on it. A lasting convention moves into `CLAUDE.md`.
* **Next** - unfinished tasks in order, with exactly what each still needs.
* **Open questions** - add new ones, remove answered ones. Only claims checked against the code or a command.

Lines wrap at 120 characters.

## 3. Hand over

Show the user a short summary of what changed in `PROJECT_STATE.md` (and `CLAUDE.md`, if a convention moved there),
then ask them to commit and push `index`. Don't commit it yourself.
