#!/bin/bash

READING=true
REMOVING=false

if [[ $1 ]]; then
  READING=false
  if [ $1 = "rm" ]; then
    REMOVING=true
  elif [[ ! $1 =~ ^[0-9]+$ ]]; then
    echo "Ticket number must be an integer"
    exit
  fi
fi

touch .git/hooks/branch-tickets.map

BRANCH_NAME=`git symbolic-ref HEAD --short`
BRANCH_MAP=`cat .git/hooks/branch-tickets.map`

regex="(.*)$BRANCH_NAME ([0-9]+)(.*)"
if [[ $BRANCH_MAP =~ $regex ]]
then
  if [ "$REMOVING" = true ]; then
    echo "${BASH_REMATCH[1]}${BASH_REMATCH[3]}" > .git/hooks/branch-tickets.map
    echo "Removed branch ticket number"
  elif [ "$READING" = true ]; then
    echo "Current branch ticket number is ${BASH_REMATCH[2]}"
  else
    echo "${BASH_REMATCH[1]}$BRANCH_NAME $1${BASH_REMATCH[3]}" > .git/hooks/branch-tickets.map
  fi
else
  if [ "$READING" = true ] || [ "$REMOVING" = true ]; then
    echo "No ticket number set for current branch"
  else
    echo "$BRANCH_NAME $1" >> .git/hooks/branch-tickets.map
  fi
fi

if [ $READING = false ] && [ "$REMOVING" = false ]; then
  echo "Current branch ticket number set to $1"
fi
