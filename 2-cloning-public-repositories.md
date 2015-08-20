# 2. Cloning Public Repositories

Perhaps you only want to use git to download someone else's project, so you can 
compile and use their software. In a lot of cases people may not even provide 
`.tar.` or `.zip` downloads, they just assume everyone knows how to use git to 
download a project. This step is easy:

### git clone

Cloning means downloading the entire repo, so you get the current code and its 
version history. (For ways to look at the history, see the next chapter.) For 
example to get a copy of the [markdown][1] source for this guide, you can

[1]: https://help.github.com/articles/markdown-basics/

```sh
git clone https://github.com/samposm/git-guide
```

This creates a new directory `git-guide`. If a directory by the same name 
already exists, git gives a warning and aborts. You can also give another name 
for the directory as a second argument:

```sh
git clone https://github.com/samposm/git-guide copy-of-git-guide
```

The source repo could also be in your filesystem. This

```sh
git clone path/to/repo
```

creates a directory `repo` under the current directory, and

```sh
git clone path/to/repo new-repo-name
```

specifies another name for the cloned repo.

Also cloning over ssh works:

```sh
git clone user@host:/absolute/path/to/repo/
git clone user@host:relative/path/to/repo/
```

By cloning you only get the files up to the latest commit. If the source 
directory contained untracked, unstaged, or staged but uncommitted work, the 
clone will not get those. (See the next chapter for what untracked, 
staged/unstaged and committed mean.)

[This section][2] of the [Pro Git book][3] tells more about different protocols
over which git can clone.

[2]: https://git-scm.com/book/tr/v2/Git-on-the-Server-The-Protocols
