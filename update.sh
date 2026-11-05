#!/bin/bash

set -euo pipefail


#======================================================================================================================
# Tidy every repository next to this one: prune deleted remote branches, delete local branches that are merged, gc,
# then pull the current branch.
#
# Repositories with uncommitted changes are skipped, and pulls only fast-forward. Branches are deleted when they are
# merged, or when their branch on GitHub has been deleted (squash-merged or abandoned - the commit is printed so it can
# be restored). Branches that were never pushed, or still exist on GitHub, are kept.
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
    # without a fresh fetch, gone branches would be judged on stale refs, so skip the repository and carry on
    if ! git -C "${DIR}" fetch --prune --quiet ; then
        echo "${NAME} .. skipped - fetch failed"
        continue
    fi

    CURRENT=$(git -C "${DIR}" branch --show-current)
    for BRANCH in $(git -C "${DIR}" for-each-ref --format='%(refname:lstrip=2)' refs/heads/) ; do
        [[ ${BRANCH} == "${CURRENT}" || ${BRANCH} == main ]] && continue
        if git -C "${DIR}" branch -d "${BRANCH}" > /dev/null 2>&1 ; then
            echo "${NAME} .. deleted merged branch ${BRANCH}"
        elif [[ $(git -C "${DIR}" for-each-ref --format='%(upstream:track)' "refs/heads/${BRANCH}") == "[gone]" ]] ; then
            # squash-merged or abandoned - print the commit so it can be restored
            SHA=$(git -C "${DIR}" rev-parse --short "refs/heads/${BRANCH}")
            git -C "${DIR}" branch -D "${BRANCH}" > /dev/null
            echo "${NAME} .. deleted branch ${BRANCH} - gone on GitHub, restore with: git branch ${BRANCH} ${SHA}"
        else
            echo "${NAME} .. kept ${BRANCH} - not merged"
        fi
    done

    echo "${NAME} .. gc"
    git -C "${DIR}" gc --quiet

    echo "${NAME} .. pull"
    git -C "${DIR}" pull --ff-only --quiet 2> /dev/null || echo "${NAME} .. pull failed - not a fast-forward, or no upstream"

done
