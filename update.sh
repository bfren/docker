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

for DIR in "${PARENT_DIR}"/*/ ; do

    DIR=${DIR%/}
    NAME=$(basename "${DIR}")
    [[ -d ${DIR}/.git ]] || continue

    if [[ -n $(git -C "${DIR}" status --porcelain) ]] ; then
        echo "${NAME} .. skipped - has uncommitted changes"
        continue
    fi

    echo "${NAME} .. prune"
    git -C "${DIR}" fetch --prune --quiet

    # -d refuses to delete a branch with commits that are not merged, so unpushed work is kept
    CURRENT=$(git -C "${DIR}" branch --show-current)
    for BRANCH in $(git -C "${DIR}" for-each-ref --format='%(refname:short)' refs/heads/) ; do
        [[ ${BRANCH} == "${CURRENT}" || ${BRANCH} == main ]] && continue
        git -C "${DIR}" branch -d "${BRANCH}" > /dev/null 2>&1 && echo "${NAME} .. deleted merged branch ${BRANCH}" \
            || echo "${NAME} .. kept ${BRANCH} - not merged"
    done

    echo "${NAME} .. gc"
    git -C "${DIR}" gc --quiet

    echo "${NAME} .. pull"
    git -C "${DIR}" pull --ff-only --quiet 2> /dev/null || echo "${NAME} .. pull failed - not a fast-forward, or no upstream"

done
