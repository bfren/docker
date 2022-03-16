#!/bin/bash

cd ..

for DIR in `ls`; do

  echo "${DIR}"
  cd ${DIR}

  echo "${DIR} .. pull"
  git pull

  echo "${DIR} .. clean"
  BRANCHES=`git branch -r | grep "origin/v" | sed 's/origin\///'`
  [[ -n "${BRANCHES}" ]] && git branch -D ${BRANCHES}

  cd ..

done
