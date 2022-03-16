#!/bin/bash

cd ..

for DIR in `ls`; do

  echo "${DIR}"
  cd ${DIR}

  echo "${DIR} .. pull"
  git pull

  echo "${DIR} .. prune"
  git remote prune origin

  echo "${DIR} .. delete merged branches"
  MERGED=`git branch -r | grep "origin/v" | sed 's/origin\///'`
  [[ -n "${MERGED}" ]] && git branch -D ${MERGED}

  echo "${DIR} .. delete not merged branches"
  NOT_MERGED=`git branch --no-merged`
  [[ -n "${NOT_MERGED}" ]] && git branch -D ${NOT_MERGED}

  cd ..

done
