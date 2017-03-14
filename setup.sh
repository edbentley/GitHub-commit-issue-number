#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# add git ticket script path to .bashrc and .bash_profile
GIT_TICKET_PATH="$DIR/git-ticket.sh"
echo "export GIT_TICKET_PATH=\"$GIT_TICKET_PATH\"" >> $HOME/.bashrc
echo "export GIT_TICKET_PATH=\"$GIT_TICKET_PATH\"" >> $HOME/.bash_profile

# add git ticket to config
git config --global alias.ticket '!sh $GIT_TICKET_PATH $1'

# create .git_template dir
if [ ! -d "$HOME/.git_template" ]; then
  mkdir -p $HOME/.git_template/hooks
fi

# symlink `prepare-commit-msg` and `branch-ticket-restrictions.sh`
ln -s $DIR/prepare-commit-msg $HOME/.git_template/hooks/prepare-commit-msg
ln -s $DIR/branch-ticket-restrictions.sh $HOME/.git_template/hooks/branch-ticket-restrictions.sh

# setup git template
git config --global init.templatedir '~/.git_template'
