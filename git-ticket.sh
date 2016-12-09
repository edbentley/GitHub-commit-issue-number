#!/bin/bash

if [ -z $1 ]; then
  READING=true
else
  READING=false
fi

touch .git/hooks/branch-tickets.map

BRANCH_NAME=`git symbolic-ref HEAD --short`
BRANCH_MAP=`cat .git/hooks/branch-tickets.map`

regex="(.*)$BRANCH_NAME ([0-9]+)(.*)"
if [[ $BRANCH_MAP =~ $regex ]]
then
  if [ "$READING" = true ]; then
    echo "Current branch ticket is ${BASH_REMATCH[2]}"
  else
    echo "${BASH_REMATCH[1]}$BRANCH_NAME $1${BASH_REMATCH[3]}" > .git/hooks/branch-tickets.map
  fi
else
  if [ "$READING" = true ]; then
    echo "No ticket set for current branch"
  else
    echo "$BRANCH_NAME $1" >> .git/hooks/branch-tickets.map
  fi
fi

if [ $READING = false ]; then
  echo "Set current branch ticket number to $1"
fi
