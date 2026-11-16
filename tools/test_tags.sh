#!/bin/bash
# Self-check for tags.sh - run with: bash tools/test_tags.sh (needs envsubst, from gettext)

set -euo pipefail

TAGS_SH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/tags.sh
REPO=$(mktemp -d)
trap 'rm -rf "${REPO}"' EXIT
cd "${REPO}"

# a repository with version files at the root, and a folder that overrides one of them
mkdir -p overlay/tmp 3.24/overlay/tmp
printf 1.2.3 > VERSION ; printf 1 > VERSION_MAJOR ; printf 1.2 > VERSION_MINOR
printf 3.23.0 > overlay/tmp/ALPINE_REVISION
printf 3.24.1 > 3.24/overlay/tmp/ALPINE_REVISION

# run tags.sh: folder, publish, tags, default folder, default tags
run() { FOLDER=$1 PUBLISH=$2 TAGS=$3 DEFAULT_FOLDER=${4:-} DEFAULT_TAGS=${5:-} bash "${TAGS_SH}" ; }
check() { [[ $1 == "$2" ]] || { printf 'expected:\n%s\ngot:\n%s\n' "$2" "$1" ; exit 1 ; } ; }

TAGS=$'alpine${FOLDER}\nalpine${ALPINE_REVISION}-${VERSION}\n'
DEFAULT=$'latest\n${VERSION_MAJOR}\n'

# a release: the folder's own file wins, and the default folder also gets the default tags
check "$(run 3.24 true "${TAGS}" 3.24 "${DEFAULT}")" $'alpine3.24\nalpine3.24.1-1.2.3\nlatest\n1'

# a development build: -dev is added to every tag, and latest becomes dev
check "$(run 3.24 false "${TAGS}" 3.24 "${DEFAULT}")" $'alpine3.24-dev\nalpine3.24.1-1.2.3-dev\ndev\n1-dev'

# another folder: the root's file is used, and there are no default tags
check "$(run 3.23 true "${TAGS}" 3.24 "${DEFAULT}")" $'alpine3.23\nalpine3.23.0-1.2.3'

# a variable with no file stops the build
if run . true '${MISSING}' 2> /dev/null ; then echo "expected a missing variable to fail" ; exit 1 ; fi

echo 'tags: all checks passed'
