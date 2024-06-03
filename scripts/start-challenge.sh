#!/bin/sh

filename=$(ls playground/**/*.ts | peco)
difficulty=$(echo $filename | sed -e 's/playground\/\(.*\)\/.*/\1/')
label=$(echo $filename | sed -e "s/playground\/.*-${difficulty}-\(.*\).ts/\1/")

git checkout main

branch_name=type/$difficulty/$label

if git rev-parse --verify $branch_name >/dev/null 2>&1; then
  git switch $branch_name
else
  git switch -c $branch_name
fi
git switch -C $branch_name

code $filename
