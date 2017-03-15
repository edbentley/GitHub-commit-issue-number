#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# add git ticket script path to .bash_profile
GIT_TICKET_PATH="$DIR/git-ticket.sh"
echo "export GIT_TICKET_PATH=\"$GIT_TICKET_PATH\"" >> $HOME/.bash_profile

echo "Added env var GIT_TICKET_PATH to .bash_profile"

# add git ticket to config
git config --global alias.ticket '!sh $GIT_TICKET_PATH $1'

echo "Added git ticket alias to .gitconfig"

# create .git_template dir
if [ ! -d "$HOME/.git_template" ]; then
  mkdir -p $HOME/.git_template/hooks
  echo "Made .git_template dir"
fi

# symlink `prepare-commit-msg` and `branch-ticket-restrictions.sh`
ln -sf $DIR/prepare-commit-msg $HOME/.git_template/hooks/prepare-commit-msg
ln -sf $DIR/branch-ticket-restrictions.sh $HOME/.git_template/hooks/branch-ticket-restrictions.sh

echo "Symlink prepare-commit-msg and branch-ticket-restrictions.sh into .git_template dir"

# setup git template
git config --global init.templatedir '~/.git_template'

echo "Set up git template destination in .gitconfig"

echo "-------"
echo "All done! Just run 'source ~/.bash_profile' and start using git ticket in your repos"
