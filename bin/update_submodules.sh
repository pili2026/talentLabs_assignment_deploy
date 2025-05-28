#!/bin/bash
set -e

echo "Updating Git submodules to latest remote commits..."
echo

git config -f .gitmodules submodule.talentLabs_assignment_fe.branch main
git config -f .gitmodules submodule.talentLabs_assignment_be.branch main

git submodule sync --recursive

git submodule update --init --recursive

git submodule update --remote --merge

echo
echo "Submodule status summary:"
echo "-----------------------------"

git submodule foreach --recursive '
  echo "[$name]"
  echo "  Branch   : $(git rev-parse --abbrev-ref HEAD)"
  echo "  Commit   : $(git rev-parse --short HEAD)"
  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "  Status : Dirty (uncommitted changes)"
  else
    echo "  Status : Clean"
  fi
  echo
'

echo "Submodules are now up-to-date and checked."
