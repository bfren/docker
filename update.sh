#!/bin/bash

set -euo pipefail


#======================================================================================================================
# Tidy every repository next to this one: prune deleted remote branches, delete local branches that are merged, gc,
# then pull the current branch.
#
# Nothing is lost: repositories with uncommitted changes are skipped, branches are only deleted when git says they are
# merged (git branch -d), and pulls only fast-forward.
#======================================================================================================================

PARENT_DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")

# succeed if branch $2 in repository $1 was squash-merged: its branch on GitHub has been deleted, and origin/main
# already has the same change as all its commits squashed together - so nothing on it would be lost
squash_merged() {
    [[ $(git -C "$1" for-each-ref --format='%(upstream:track)' "refs/heads/$2") == "[gone]" ]] || return 1
    git -C "$1" rev-parse -q --verify origin/main > /dev/null || return 1
    local BASE SQUASH
    BASE=$(git -C "$1" merge-base origin/main "$2") || return 1
    SQUASH=$(git -C "$1" commit-tree --no-gpg-sign "$2^{tree}" -p "${BASE}" -m squash)
    [[ $(git -C "$1" cherry origin/main "${SQUASH}") == "-"* ]]
}

for DIR in "${PARENT_DIR}"/*/ ; do

    DIR=${DIR%/}
    NAME=$(basename "${DIR}")
    [[ -d ${DIR}/.git ]] || continue

    if [[ -n $(git -C "${DIR}" status --porcelain) ]] ; then
        echo "${NAME} .. skipped - has uncommitted changes"
        continue
    fi

    echo "${NAME} .. prune"
    # without a fresh fetch the squash-merge check could use stale refs, so skip the repository and carry on
    if ! git -C "${DIR}" fetch --prune --quiet ; then
        echo "${NAME} .. skipped - fetch failed"
        continue
    fi

    # -d refuses to delete a branch with commits that are not merged, so unpushed work is kept
    CURRENT=$(git -C "${DIR}" branch --show-current)
    for BRANCH in $(git -C "${DIR}" for-each-ref --format='%(refname:short)' refs/heads/) ; do
        [[ ${BRANCH} == "${CURRENT}" || ${BRANCH} == main ]] && continue
        if git -C "${DIR}" branch -d "${BRANCH}" > /dev/null 2>&1 ; then
            echo "${NAME} .. deleted merged branch ${BRANCH}"
        elif squash_merged "${DIR}" "${BRANCH}" ; then
            git -C "${DIR}" branch -D "${BRANCH}" > /dev/null
            echo "${NAME} .. deleted squash-merged branch ${BRANCH}"
        else
            echo "${NAME} .. kept ${BRANCH} - not merged"
        fi
    done

    echo "${NAME} .. gc"
    git -C "${DIR}" gc --quiet

    echo "${NAME} .. pull"
    git -C "${DIR}" pull --ff-only --quiet 2> /dev/null || echo "${NAME} .. pull failed - not a fast-forward, or no upstream"

done
