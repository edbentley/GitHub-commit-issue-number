# GitHub Commit Ticket Number
Automatically reference the ticket number (issue or pull request) for a particular branch in your commit message.

```
$ git commit -m "add meaning of life"
[branch 2d39dc8] add meaning of life #42
```

## How to set up

- Put `git-ticket.sh` script somewhere, e.g. `~/scripts/git-ticket.sh`
- Add alias to your `.config` file (change path to where you put `git-ticket.sh`):

  ```
  git config --global alias.ticket '!sh ~/scripts/git-ticket.sh $1'
  ```
- Place `prepare-commit-msg` and `branch-ticket-restrictions.sh` in `~/.git_template/hooks` and run

  ```
  git config --global init.templatedir '~/.git_template'
  ```

  When you next clone or set up a repo these files will be copied into your `.git` directory. For your existing repos, `git init` will be called automatically (which will copy the files to your `.git` directory) when you call `git ticket` for the first time.

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
  $ git ticket app#42
  Current branch ticket number set to 'app#42'
  ```


## Add branch restrictions

- Edit `branch-ticket-restrictions.sh` to add restrictions to branches you can set a ticket for. You can restrict certain branch names, or enforce a prefix.
- Check current restrictions in repo by calling:
  ```
  git ticket restrict
  ```
