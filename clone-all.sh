#!/bin/bash

set -euo pipefail


#======================================================================================================================
# Clone any missing image repositories next to this one, so the layout matches the VS Code workspace:
#   <parent>/index, <parent>/alpine, <parent>/alpine-s6, ...
#
# The list of images is read from docker-index.code-workspace, so add new images there.
# Existing repositories are left alone - run with --pull to also pull them (only if they're on a clean 'main').
#======================================================================================================================

INDEX_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PARENT_DIR=$(dirname "${INDEX_DIR}")
WORKSPACE=${INDEX_DIR}/docker-index.code-workspace
PULL=${1:-}


#======================================================================================================================
# Get the list of images from the workspace folder names (excluding index).
#======================================================================================================================

IMAGES=$(grep '"name"' "${WORKSPACE}" | sed 's/.*"name": *"//; s/".*//' | grep -v '^index$')


#======================================================================================================================
# Clone each missing image, and optionally pull existing ones.
#======================================================================================================================

CLONED=0 ; PULLED=0 ; SKIPPED=0
for IMAGE in ${IMAGES} ; do

    DIR=${PARENT_DIR}/${IMAGE}

    if [[ ! -d "${DIR}" ]] ; then
        echo "Cloning ${IMAGE}."
        git clone "https://github.com/bfren/docker-${IMAGE}.git" "${DIR}"
        CLONED=$((CLONED + 1))
        continue
    fi

    if [[ "${PULL}" != "--pull" ]] ; then
        continue
    fi

    BRANCH=$(git -C "${DIR}" rev-parse --abbrev-ref HEAD)
    if [[ "${BRANCH}" != "main" || -n "$(git -C "${DIR}" status --porcelain)" ]] ; then
        echo "Skipping ${IMAGE} - on '${BRANCH}' or has uncommitted changes."
        SKIPPED=$((SKIPPED + 1))
        continue
    fi

    echo "Pulling ${IMAGE}."
    git -C "${DIR}" pull --ff-only
    PULLED=$((PULLED + 1))

done

echo "Done: ${CLONED} cloned, ${PULLED} pulled, ${SKIPPED} skipped."
