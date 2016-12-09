# GitHub-commit-ticket-number
Automatically reference the ticket number for a particular branch in your commit message.

## How to set up:

- Put git-ticket.sh script somewhere
- Add alias to your .config file (change path to where you put git-ticket.sh):

  ```
  $ git config --global alias.ticket '!sh ~/scripts/git-ticket.sh $1'
  ```
- Add prepare-commit-msg to .git folder (or append code if it already exists). This will need to be done for each repo.

TODO: Add to template: http://stackoverflow.com/questions/2293498/git-commit-hooks-global-settings
