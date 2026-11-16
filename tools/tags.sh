#!/bin/bash
#
# Print the tags for one folder of an image, one per line - run by the merge job in .github/workflows/build.yml, from
# the image repository's root. Reads from the environment:
#
#   FOLDER          the folder being built ('.' for the repository root)
#   TAGS            tags, one per line, using ${FOLDER} and version files as variables
#   DEFAULT_FOLDER  the folder that also gets DEFAULT_TAGS (may be empty)
#   DEFAULT_TAGS    extra tags for DEFAULT_FOLDER, one per line
#   PUBLISH         'true' for a release - anything else is a development build: -dev is added and latest becomes dev
#
# Tests: bash tools/test_tags.sh

set -euo pipefail

# load version files as variables - later files win, so the folder's own files override the repository's
for file in VERSION* overlay/tmp/* "${FOLDER}"/* "${FOLDER}"/overlay/tmp/* ; do
  name=${file##*/}
  if [[ -f ${file} && ${name} =~ ^[A-Z0-9_]+$ ]] ; then export "${name}=$(< "${file}")" ; fi
done

# fill in the tags, stopping if a variable has no file - development builds add -dev, and latest becomes dev
[[ ${FOLDER} != "${DEFAULT_FOLDER:-}" ]] || TAGS+=$'\n'"${DEFAULT_TAGS:-}"
for var in $(envsubst --variables "${TAGS}") ; do
  [[ -n ${!var:-} ]] || { echo "No file for \$${var} in ${FOLDER}, ${FOLDER}/overlay/tmp, overlay/tmp or the root" >&2 ; exit 1 ; }
done
tags=$(envsubst <<< "${TAGS}" | grep .)
[[ ${PUBLISH:-} == true ]] || tags=$(sed -e 's/^latest$/dev/' -e '/^dev$/!s/$/-dev/' <<< "${tags}")
echo "${tags}"
