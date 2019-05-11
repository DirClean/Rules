#!/bin/sh

setup_git() {
  git config --global user.email "${PUSH_EMAIL}"
  git config --global user.name "${PUSH_NAME}"
}

commit_files() {
  git add .
  git commit --author "${PUSH_NAME} <${PUSH_EMAIL}>" -m "Update from build $TRAVIS_BUILD_ID"
}

upload_files() {
  git push https://Trumeet:${PUSH_TOKEN}@github.com/DirClean/Rules.git HEAD:docs
}

cd ~/publish
setup_git
commit_files
upload_files
