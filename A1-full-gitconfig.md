# Appendix 1. Full `.gitconfig`

The full `.gitconfig` that we build during this guide:

```
[user]
    name = Your Name
    email = your@email
[core]
    editor = gedit
[alias]
    lg = log --all --graph --decorate --oneline
    acommit = !git add --all && git commit
    ucommit = !git add --update && git commit
[diff]
    tool = meld
[difftool]
    prompt = false
[color "status"]
    untracked = cyan
    changed = bold red
```
