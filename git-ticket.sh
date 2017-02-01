#!/bin/bash

RESTRICTIONS_FILE=".git/hooks/branch-ticket-restrictions.sh"
BRANCH_MAP_FILE=".git/hooks/branch-tickets.map"
PREPARE_COMMIT_FILE=".git/hooks/prepare-commit-msg"
GIT_INIT_TEMPLATE="$HOME/.git_template/hooks/prepare-commit-msg"

if [ ! -e $PREPARE_COMMIT_FILE ]; then
  if [ -e $GIT_INIT_TEMPLATE ]; then
    echo "Repo git hooks not set up, calling 'git init' for you now"
    git init
  else
    echo "Error: your git hooks are not set up"
    exit
  fi
fi

if [ -e $RESTRICTIONS_FILE ]; then
  source $RESTRICTIONS_FILE
else
  RESTRICTED=("")
  PREFIXES=("")
fi

READING=true
REMOVING=false

touch $BRANCH_MAP_FILE

BRANCH_NAME=`git symbolic-ref HEAD --short`
BRANCH_MAP=`cat $BRANCH_MAP_FILE`

function contains() {
  local n=$#
  local value=${!n}
  for ((i=1;i < $#;i++)) {
    if [ "${!i}" == "${value}" ]; then
      echo "y"
      return 0
    fi
  }
  echo "n"
  return 1
}
function startsWith() {
  local n=$#
  local value=${!n}
  for ((i=1;i < $#;i++)) {
    if [[ ${value} =~ ^${!i}.* ]]; then
      echo "y"
      return 0
    fi
  }
  echo "n"
  return 1
}

if [[ $1 ]]; then
  READING=false
  if [ $1 = "rm" ]; then
    REMOVING=true
  elif [ $1 = "restrict" ]; then
    if [ -e $RESTRICTIONS_FILE ]; then
      echo "Restrictions can be edited in file '$RESTRICTIONS_FILE'"
      if [ ${#RESTRICTED[@]} -eq 0 ]; then
        echo "No restricted branch names"
      else
        echo "Current restricted branch names:"
        printf ' > %s\n' "${RESTRICTED[@]}"
      fi
      if [ ${#PREFIXES[@]} -eq 0 ]; then
        echo "No enforced branch name prefixes"
      else
        echo "Current enforced branch name prefixes:"
        printf ' > %s\n' "${PREFIXES[@]}"
      fi
    else
      echo "No restrictions file found at '$RESTRICTIONS_FILE'"
    fi
    exit
  else
    if [ $(contains "${RESTRICTED[@]}" "$BRANCH_NAME") == "y" ]; then
      echo "Error: branch $BRANCH_NAME is a restricted branch name"
      echo "Restrictions can be edited in file '$RESTRICTIONS_FILE'"
      exit
    elif [ ! ${#PREFIXES[@]} -eq 0 ]; then
      if [ $(startsWith "${PREFIXES[@]}" "$BRANCH_NAME") == "n" ]; then
        echo "Error: branch name $BRANCH_NAME doesn't contain one of the following prefixes:"
        printf ' > %s\n' "${PREFIXES[@]}"
        echo "Restrictions can be edited in file '$RESTRICTIONS_FILE'"
        exit
      fi
    fi
  fi
fi

regex="(.*) $BRANCH_NAME ([^ ]+) (.*)"
if [[ $BRANCH_MAP =~ $regex ]]
then
  if [ "$REMOVING" = true ]; then
    echo "${BASH_REMATCH[1]}${BASH_REMATCH[3]}" > $BRANCH_MAP_FILE
    echo "Removed branch ticket number"
  elif [ "$READING" = true ]; then
    echo "Current branch ticket number is '${BASH_REMATCH[2]}'"
  else
    echo "${BASH_REMATCH[1]} $BRANCH_NAME $1 ${BASH_REMATCH[3]}" > $BRANCH_MAP_FILE
  fi
else
  if [ "$READING" = true ] || [ "$REMOVING" = true ]; then
    echo "No ticket number set for current branch"
  else
    echo " $BRANCH_NAME $1 " >> $BRANCH_MAP_FILE
  fi
fi

if [ $READING = false ] && [ "$REMOVING" = false ]; then
  echo "Current branch ticket number set to '$1'"
fi

# new line cleanup
CLEANUP=`sed '/^$/d' $BRANCH_MAP_FILE`
echo "$CLEANUP" > $BRANCH_MAP_FILE
