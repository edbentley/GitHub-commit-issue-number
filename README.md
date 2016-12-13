# GitHub Commit Ticket Number
Automatically reference the ticket number (issue or pull request) for a particular branch in your commit message.

```
$ git commit -m "add meaning of life"
[branch 2d39dc8] add meaning of life #42
```

## How to set up

- Put `git-ticket.sh` script somewhere convenient.
- Add alias to your `.config` file (change path to where you put `git-ticket.sh`):

  ```
  $ git config --global alias.ticket '!sh ~/scripts/git-ticket.sh $1'
  ```
- Add `prepare-commit-msg` to `.git/hooks/` directory OR use `.git_template` below (or append code if it already exists). This will need to be done for each repo.
- You can have this file included by default when running `git init` by
  - Placing `prepare-commit-msg` in `~/.git_template/hooks`
  - `$ git config --global init.templatedir '~/.git_template'`
  
  This will add the file even if you call `git init` in an existing repo.

## How to use

- Set the ticket number for current branch:
  ```
  git ticket 42
  ```
  When you next commit, the issue number will be added to the first line of your commit message. If you commit without a message the ticket number can be edited in the text editor.

- Show ticket number for current branch:
  ```
  git ticket
  ```
- Remove ticket number for current branch:

  ```
  git ticket rm
  ```
