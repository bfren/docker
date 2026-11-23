---
name: close-session
description: Close a working session - bring the index README's image versions up to date, rewrite PROJECT_STATE.md (the handoff to the next session) from what this session did and decided, then commit and push both. Use for "close the session", "wrap up", "end of session", "update the project state", /close-session.
---

# Close the session

`PROJECT_STATE.md` and the versions in the `index` `README.md` are written once, here, at the end of a session - not
during it. Run from `index`.

## 1. Gather

Work out the current state from this conversation, then check it against the repositories rather than trusting
earlier messages, which may be out of date.

Earlier sessions may have ended without this skill, so also find everything since `PROJECT_STATE.md` was last
committed, in every image - not only those this conversation touched:

```bash
SINCE=$(git log -1 --format=%cI -- PROJECT_STATE.md)
for i in $(grep '"name"' docker-index.code-workspace | sed 's/.*"name": *"//; s/".*//' | grep -v '^index$' | grep -v '^bin/'); do
  echo "== $i"; git -C ../$i fetch --tags --quiet
  git -C ../$i log --all --since="$SINCE" --format='%h %cs %D %s'
  gh release list -R bfren/docker-$i --limit 5 --json tagName,publishedAt -q ".[] | select(.publishedAt > \"$SINCE\") | .tagName"
done
git log --since="$SINCE" --format='%h %cs %s'   # index itself
```

Treat what this finds like work done this session - releases made, branches in progress, index changes - and include
it in steps 2 and 3. If it's unclear why something was done, say so rather than guessing a reason.

* For each image touched this session or found above: `git -C ../<image> status -sb` (uncommitted or unpushed work), whether its
  release exists (`gh release view v<VERSION> -R bfren/docker-<image>`), and the result of its latest development
  build if it was waiting on one.
* Read the current `PROJECT_STATE.md`: its Next tasks and Open questions carry over unless this session finished or
  answered them.

## 2. Update the index README

For each image released or prepared for release since `PROJECT_STATE.md` was last updated (step 1), check the versions its row in `README.md` lists (OS,
application, BusyBox, Nushell, S6) against its source (`CLAUDE.md` - "README conventions", the table there), and fix
any that changed. Leave the other rows alone.

Then run `python3 tools/fmt_tables.py apply --shared README.md` and `check` - it must report `0 table(s) misaligned`.
If nothing changed, skip this step.

## 3. Rewrite `PROJECT_STATE.md`

Follow `CLAUDE.md` - "Project state". Write the file once, in its final form:

* **Last session (YYYY-MM-DD)** - replace the section. Say what was done and what was decided, with the reasoning,
  including anything step 1 found from sessions that weren't closed.
  Group images in the same state on one line (e.g. "Released a, b and c", "Ready to tag: d and e") rather than one
  bullet per image, and keep only what the next session needs: commit hashes and build numbers only for work still
  waiting on something.
* **Decisions** - keep one only while an unfinished task depends on it. A lasting convention moves into `CLAUDE.md`.
* **Next** - unfinished tasks in order, with exactly what each still needs.
* **Ruled out** - carry over existing entries, and add each approach this session tried or seriously considered and
  dropped (a reverted commit, a fix that didn't work, an option rejected after testing): one line naming the image or
  area, what was tried and why it was dropped. A rejected approach recorded under Decisions belongs here instead.
  Remove an entry once the code it concerns has changed so the reason no longer holds. One that applies across the
  ecosystem whatever the code does moves into `CLAUDE.md`.
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
