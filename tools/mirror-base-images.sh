#!/bin/bash
#
# Copy the current official Alpine and Debian slim releases from Docker Hub to quay.io/bfren-bin, so image builds do
# not hit Docker Hub's pull rate limits. The images are copied unchanged, so they keep the same digests.
#
# Run daily by .github/workflows/mirror-base-images.yml. To run it locally (needs bash, curl, jq and skopeo):
#
#   docker run --rm -it -v "${PWD}:/w" -w /w --entrypoint sh quay.io/bfren/alpine:alpine3.24 \
#       -c "apk add -q bash curl jq skopeo && skopeo login quay.io && bash tools/mirror-base-images.sh"
#
# Docker Hub is read anonymously unless DOCKERHUB_USERNAME and DOCKERHUB_TOKEN are set. Every manifest fetched from
# Docker Hub counts as a pull (about 16 per multi-platform image), so only the current release behind each floating
# tag is copied, and only if it is not already on Quay.io.

set -euo pipefail

# Alpine minor and Debian major versions used by bfren images - keep in step with docker-alpine and docker-debian
ALPINE_MINORS="${ALPINE_MINORS:-3.20 3.21 3.22 3.23 3.24}"
DEBIAN_MAJORS="${DEBIAN_MAJORS:-12 13}"

# credentials for Docker Hub, if set
SRC_CREDS=()
if [ -n "${DOCKERHUB_USERNAME:-}" ] && [ -n "${DOCKERHUB_TOKEN:-}" ] ; then
  SRC_CREDS=(--src-creds "${DOCKERHUB_USERNAME}:${DOCKERHUB_TOKEN}")
fi

# print the digest of the image at $1 (the hash of its exact manifest bytes), or nothing if it does not exist
MANIFEST=$(mktemp)
digest() { skopeo inspect --raw "$1" > "${MANIFEST}" 2> /dev/null || return 0 ; echo "sha256:$(sha256sum < "${MANIFEST}" | cut -c1-64)" ; }

# copy the release behind floating tag $2 (e.g. 3.24) of docker.io/library/$1 to quay.io/bfren-bin/$1:
#   $3 - filter for Docker Hub's tag list that includes the release tags (e.g. '3.24.')
#   $4 - regex matching release tags (e.g. 3.24.3)
# Docker Hub's tag API is not a pull, so finding the release does not count towards the rate limit
mirror() {
  HUB="https://hub.docker.com/v2/repositories/library/$1/tags"
  DIGEST=$(curl -fsSL "${HUB}/$2" | jq -r .digest)
  RELEASE=$(curl -fsSL "${HUB}?page_size=100&name=$3" | jq -r --arg d "${DIGEST}" '.results[] | select(.digest == $d) | .name' | grep -E "$4" | head -1 || true)
  if [ -z "${RELEASE}" ] ; then echo "Unable to find the release tag behind $1:$2." >&2 ; exit 1 ; fi

  TARGET="docker://quay.io/bfren-bin/$1"
  if [ "$(digest "${TARGET}:${RELEASE}")" = "${DIGEST}" ] ; then
    echo "$1:${RELEASE} is up to date."
  else
    echo "Copying $1:${RELEASE} (${DIGEST})."
    skopeo copy --all --preserve-digests ${SRC_CREDS[@]+"${SRC_CREDS[@]}"} "docker://docker.io/library/$1@${DIGEST}" "${TARGET}:${RELEASE}"
  fi

  # point the floating tag at the release - copied within Quay.io, so not a Docker Hub pull
  if [ "$(digest "${TARGET}:$2")" != "${DIGEST}" ] ; then
    echo "Pointing $1:$2 at ${RELEASE}."
    skopeo copy --all --preserve-digests "${TARGET}:${RELEASE}" "${TARGET}:$2"
  fi
}

for MINOR in ${ALPINE_MINORS} ; do
  mirror alpine "${MINOR}" "${MINOR}." "^${MINOR//./\\.}\.[0-9]+$"
done

for MAJOR in ${DEBIAN_MAJORS} ; do
  mirror debian "${MAJOR}-slim" "${MAJOR}." "^${MAJOR}\.[0-9]+-slim$"
done
