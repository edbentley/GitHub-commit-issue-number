# git ticket

Automatically reference the ticket number (issue or pull request) for a particular branch in your commit message.

```
$ git commit -m "add meaning of life"
[branch 2d39dc8] add meaning of life #42
```

## How to set up

- Clone / download repo
- Run `setup.sh`
- `source ~/.bash_profile`

When you call `git ticket` in a repo the git hooks will be set up automatically (by calling `git init`). So simply head straight into your repos and start using!

NOTE: running `setup.sh` will
  - export variable `GIT_TICKET_PATH` in `~/.bash_profile`
  - Add alias `git ticket` to your `~/.gitconfig` file
  - Symbolic link `prepare-commit-msg` and `branch-ticket-restrictions.sh` into `~/.git_template/hooks`
  - Setup git template to auto-add above files into your repos

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
- Custom strings are also supported for ticket numbers, for example to reference other repos:

  ```
  $ git ticket Company/app#42
  Current branch ticket number set to 'Company/app#42'
  ```

## Add branch restrictions

- Edit `branch-ticket-restrictions.sh` to add restrictions to branches you can set a ticket for. You can restrict certain branch names, or enforce a prefix. By default this file is a symlink to the git-ticket repo's file you cloned / downloaded.
- Check current restrictions in repo by calling:

  ```
  git ticket restrictions
  ```

## Clear existing git ticket

```
rm */.git/hooks/prepare-commit-msg
rm */.git/hooks/branch-ticket-restrictions.sh
rm */.git/hooks/branch-tickets.map
rm ~/.git_template/hooks/branch-ticket-restrictions.sh
rm ~/.git_template/hooks/prepare-commit-msg
```
