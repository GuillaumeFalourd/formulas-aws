#!/bin/bash

checkCommand() {
  if ! command -v "$1" >/dev/null; then
    echo "Error: $1 command required"
    exit 1
  fi
}

removeSpaces() {
  echo "${1}" | xargs | tr " " -
}

checkSpace() {
  tmp="$1"

  if [[ "$1" = *" "* ]]; then
    echo >&2 "Removing spaces from Project name..."
    tmp=$(removeSpaces "$1")
    echo >&2 "Project name without spaces: $tmp"
  fi

  echo "$tmp"
}

checkProjectName() {
  if [[ ! "$1" =~ ^[a-zA-Z0-9-]+$ ]]; then
    echo "Project name cannot contain special characters"
    exit 1
  fi
}

run() {
  checkCommand git

  RIT_PROJECT_NAME=$(checkSpace "$RIT_PROJECT_NAME")

  checkProjectName "$RIT_PROJECT_NAME"

  if [[ "$RIT_WORKSPACE_PATH" != " " ]]; then
    cd "$RIT_WORKSPACE_PATH" || exit 1
  else
    mkdir "$RIT_PROJECT_NAME"
    cd "$RIT_PROJECT_NAME" || exit 1
    echo "$RIT_PROJECT_DESCRIPTION" >> README.md
  fi

  git init

  git add .
  git commit -m "Initial Commit"

  curl -H 'Authorization: token '"$RIT_GITHUB_TOKEN" https://api.github.com/user/repos -d '{"name":"'"$RIT_PROJECT_NAME"'", "private":'"$RIT_REPO_PRIVACY"'}' &&
  git remote add origin https://"$RIT_GITHUB_USER":"$RIT_GITHUB_TOKEN"@github.com/"$RIT_GITHUB_USER"/"$RIT_PROJECT_NAME".git &&
  git push origin master

  echo "✅ Repository successfully initialized with git and added on Github!!"
}
