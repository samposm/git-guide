# 4. Creating Repositories and Commits

We initialize a new repository for our project and start saving snapshots or,
as we say in git speak, committing changes.

## Create a Repository: `git init`

Create a new project

```sh
mkdir myproject
cd myproject
git init
```

`git init` will create a hidden `.git` directory (so, `myproject/.git`) where
git will keep all its stuff. In a strict sense, the `.git` directory is now a 
repository, or repo for short. In everyday language, the whole `myproject` 
directory, containing both the working files (Or working tree, as it is called
in git slang. Tree, because it usually contains subdirectories, too.) and the
 `.git` directory, is a project repository. If you for some reason want to
totally delete your project's version history, you can just `rm -rf .git` and
the version history is destroyed. Also the `.git` directory contains just
ordinary files, so you can copy, zip or tar either the `.git` directory or the 
whole project directory and copy or move it around, and it will still function
as a repository in the new place, wherever you put it.

## Commit Changes: `git add` and `git commit`

Now we need some files

```sh
$EDITOR a.txt
git add a.txt
git commit -m'First commit: add a.txt'
```

We create a text file, write some text in it, then we *add* the file to git's
list of files to be committed, also called the *staging area*, or *index*. Then
we save (or commit) a snapshot (or a commit) of our project. Let's go on

```sh
$EDITOR a.txt
git add a.txt
git commit -m'Edit a.txt'
```

That `-m` is a short way to add a one-line commit message right in the command
line. We can also write longer commit messages

```sh
$EDITOR b.txt
git add b.txt
git commit
```

Now git will open your favorite editor (if you configured it in Chapter 1), and
you can write:

    Add new file: b.txt

    Are two files really better than one? Or perhaps the sweet spot would be
    three files ...Can we have a non-integer number of files?

    # Please enter the commit message for your changes. Lines starting
    # with '#' will be ignored, and an empty message aborts the commit.
    # On branch master
    # Changes to be committed:
    #       new file:   b.txt
    #

## Commit Messages

Traditionally, we first write a simple one-line description of the commit, then
leave one empty line, and then we can write as long a commit message as we
want. After this, save and exit the editor. The commit is done.

By git tradition, we write the commit messages in active tense: *add file*
instead of *added file*. Kind of thinking about someone else who is considering
to perhaps include our commits in their version of the project: What will
adding the work in these commits *do*, instead of what we *did*. Also, it is a
couple of letters shorter. You can of course write your commit messages however
you like. There are [longer treatments][tpope] on git commit message best
practices available

[tpope]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

## Removing Files: `git rm`

If you want the next commit to record that a file is removed from the
project, you can

```sh
git rm file.txt
```

This will also remove the file from the working directory. The same can be
done by

```sh
rm file.txt
git add file.txt
```

This will also, obviously, remove the working copy of the file. This is useful
if you have already removed the file by ordinary `rm` and want to stage the
removal for the next commit.

If you want to only record the file removal into the next commit, but not
actually remove the file from the work directory, use

```sh
git rm --cached file.txt
```

After this, `git status` will show the file as untracked.

## Stay Informed

### `git log`

Now we can view the project log:

```sh
git log
```

    commit ac2e1a239487e61bacfb6016bd18337df2596448
    Author: Sampo <sampo.smolander@helsinki.fi>
    Date:   Sat Aug 15 23:46:39 2015 -0400

        Add new file: b.txt

        Are two files really better than one? Or perhaps the sweet spot would be
        three files ...Can we have a non-integer number of files?

    commit ffdabdc5b1caa8714d6bb679d1a59db60a4780f4
    Author: Sampo <sampo.smolander@helsinki.fi>
    Date:   Sat Aug 15 23:35:42 2015 -0400

        Edit a.txt

    commit d7b4272c7a6057e496f3b2b85b45449fdb3f3d41
    Author: Sampo <sampo.smolander@helsinki.fi>
    Date:   Sat Aug 15 23:35:05 2015 -0400

        First commit: add a.txt

Here, each commit is identified by a hash-code. The first commit by
`d7b4272...` and so on.

**Why not number the commits?** At its roots, git is designed for collaborative
work, where commits are seen as quite independent units, sometimes also called
changesets. Say I am working on a project, and someone else contributes some
important bugfixes. I can take only those commits that contain the piece of
work that they made on the bugfixes. I would then apply only these commits on
top my ongoing work. (Actually, I might apply them to the *bottom* of my ongoing
work, but we'll come to rebasing in a later chapter.) In these situations, a
linear numbering of commits would be different for each person, and thus git
doesn't attempt to do numbering at all.

Instead git calculates a [SHA-1][1] identifier from the contents and the commit
message of a commit, and uses that to identify a commit. You don't need to use
the full 20-character hash when referring to a commit. In a project with a
small amount of commits, you can use as little as the first 4 characters. If
the project grows to thousands of commits, just four characters may not be
enough to uniquely define a commit, so you might need some more. Usually people
use seven, but a large project will [need more][2].

[1]: https://en.wikipedia.org/wiki/SHA-1
[2]: http://blog.cuviper.com/2013/11/10/how-short-can-git-abbreviate/

`git log` can take a lot of options to format the log differently. I tend to
like

```sh
git log --all --graph --decorate --oneline
```

    * ac2e1a2 (HEAD, master) Add new file: b.txt
    * ffdabdc Edit a.txt
    * d7b4272 First commit: add a.txt

You can also view the log for a certain range of commits

```sh
git log <commit-a>..<commit-b>
```

This shows every commit after a (excluding a) until b (including b). Add option
`--boundary` to also include a.

You can view only those commits in the log which modify a specified file


```sh
git log -- path/to/file
```

[Here is a tutorial][3] on many other ways to filter the log.

[3]: https://www.atlassian.com/git/tutorials/git-log/formatting-log-output

### Alias

I like it so much that I make an *alias* for it, by adding this to my
`~/.gitconfig`:

    [alias]
        lg = log --all --graph --decorate --oneline

So from now on I can just say `git lg`.

### `git help <command>`

You can also look at `git help log`, or `man git-log`, to see what kind of
options `log` takes, but the manpage is long. There help pages for all git
commands.

### `git status`

Because we just committed above, and have made no new changes, our status is
clean:

```sh
git status
```

    On branch master
    nothing to commit, working directory clean

If we make a new file, git will tell us it sees it, but it will not touch it.

```sh
$EDITOR x.txt
git status
```

    On branch master
    Untracked files:
      (use "git add <file>..." to include in what will be committed)

        x.txt

    nothing added to commit but untracked files present (use "git add" to track)

Or if we edit a file that already exists in the repository, git will notify us
that it has changed.

```sh
$EDITOR b.txt
git status
```

    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   b.txt

    Untracked files:
      (use "git add <file>..." to include in what will be committed)

        x.txt

    no changes added to commit (use "git add" and/or "git commit -a")

In general, the status of a file can be one of these four:

* **Untracked:** File exists in the working directory, but not in the
  repository. (Or more exactly not in the previous commit.) Normal git
  operations will not touch these files, but there are commands like
  `git clean` which specifically clean the project directory from
  untracked files.

* **Committed:** File has been committed in some previous commit, and has not
  been edited since. The file in the working directory is the same version as in
  the repository. `git status` will keep quiet about these.

* **Staged:** You have run `git add` on the file, so the file is staged to be
  committed, but you have not run `git commit` yet. Specifically, the version of
  the file at the moment when you ran `git add` is staged for the commit.

* **Modified:** File has been modified, and the changes have not been staged
  (`git add`) or committed.

Actually, a file can be both staged and modified, if you have further edited
the file after staging it.

**Colors:** I personally don't like some of the default colors used by `git
status`, so I add to my `.gitconfig`

    [color "status"]
        untracked = cyan
        changed = bold red

The default for both of these is red. Red is a very strong color, and I don't
like my untracked files to scream at me in red, thus cyan. But modified tracked
files which are not staged for commit yet, I like them to scream at me in bold
red, not just ordinary red.

If `git status` is too verbose for you, `git status -s` (`git status --short`)
gives shorter output.

## The staging area, or index

Most version control systems don't have the concept of staging. Either a file
is unmodified after the last commit, or it has uncommitted changes, and that's
it. But in git, the commit process has two steps:

First use `git add` to prepare the files into the staging area, and then run
`git commit`. The files you stage with `git add` can be a subset of the files
you have edited, and only this subset will be committed. The other modified
files will keep their status as modified, and their modified content is not
committed. You can add several files in one command (`git add a.txt b.txt`),
and use all normal shell wildcards (`git add *.txt` etc.). If you have staged a
file, and edit it further, you need to stage it again (run `git add` again) for
the new edits to be staged for the next commit.

You can stage all files, *including* previously untracked files, that have been
modified since last commit, by `git add --all`. Or you can stage all modified
files, *excluding* untracked files, by `git add --update`. Also, `git commit
-a` is a shorthand for `git add --update ; git commit`.

Some people feel that this extra "holding area" is just an unnecessary
complication. Nothing stops you from adding something like

    acommit = !git add --all && git commit
    ucommit = !git add --update && git commit

to the `[alias]` section of your `.gitconfig`. (The `!` syntax tells git to run
the whole alias as a shell command, so we can use `&&` to combine two commands.)
Well, `git ucommit` does now the same things as `git commit -a`.

Other people like the staging area. For example, you can modify your Makefile,
but then only commit modified code files, as long as you don't `git add` the
modified Makefile. Or, after completing a larger piece of work, you can review
the changes you have made, one file at a time, and add the files to the staging
area as a bookkeeping mechanism: these are the files that I have already
reviewed. Or, after some work modifying several files, you can commit the files
in separate commits, if that fees like a good idea. (Git even allows for
[interactive staging][4], to select only part of the edits to a file to be
staged for next commit.)

[4]: https://git-scm.com/book/en/v2/Git-Tools-Interactive-Staging

### Unstaging

If you want to remove a file from the staging area, so effectively undo `git
add file.txt`:

```sh
git reset file.txt
```

**Exception:** If you have staged a file removal and the file is also removed
from the working directory, and you want to undo the staging, you need to use
the syntax `git reset -- file.txt` instead of `git reset file.txt`. The longer
syntax works always, but only in that case it is needed. After undoing the add
you could then also restore the file by

```sh
git show HEAD:file.txt > file.txt
```

but actually

```
git checkout HEAD file.txt
```

does the same, and is shorter. Also, if you wanted to both undo the staging of
the file removal and retrieve the file from the most recent commit, you don't
need the `reset` command at all, `git checkout HEAD file.txt` actually does
both steps. (But if the file was staged for removal, but not removed from the
working directory, and also contained uncommitted modifications, this will
overwrite the file.)

## Looking Back in Time

### `git show`

You can get the contents of the version of a file in the index (staging area)
by

```sh
git show :file.txt
```

and the contents of a file in the most recent commit by


```sh
git show HEAD:file.txt
```

`HEAD` refers to the most recent commit. For the second most recent,

```sh
git show HEAD~1:file.txt
```

and so forth. You can also refer to a commit by its hash,

```sh
git show d7b4272:file.txt
```

If you are in a different directory than the files you are trying to show, you
need to use the correct path after the colon.

### `git diff`

```sh
git diff file.txt
```

shows the [diff][5] from the file in the staging area to the file in the
working directory.

[5]: https://en.wikipedia.org/wiki/Diff_utility

```sh
git diff HEAD file.txt
```

shows the diff from the most recent commit to the working file. Use
`HEAD~1`, `HEAD~2` etc., or the commit hash, for older commits.

```sh
git diff --cached file.txt
git diff HEAD:file.txt :file.txt
```

both show the diff from the last commit to the staged version of the file.

## Using a Graphical diff Viewer

You can open a file in an external diff viewer, I like [Meld][6] (Ubuntu: `sudo
apt-get install meld`). If you just open a working file

```sh
meld file.txt &
```

meld is clever enough to show the last committed version on the left, and the 
working copy on the right:

![meld diff viewer][meld-screenshot]

Unfortunately meld is not clever enough to let you see older commits. But if
you configure in your `.gitconfig`

    [diff]
        tool = meld
    [difftool]
        prompt = false

you can for example

```sh
git difftool d7b4272:a.txt a.txt
```

to open meld to compare any two versions of a file you want. Just to remind:
`file.txt` means the working copy of a file, `:file.txt` means the version of
the file in the staging area, and `<commit-identifier>:file` specifies the file
in a commit. In the above case, also a bit shorter `git difftool d7b4272 a.txt`
would work. The first argument specifies only the commit, and the second
argument specifies the working copy of the file, so then git is able to guess
that we want to view the same filename from the commit. But this shorter form
only works if the second argument is the working copy.


[6]: http://meldmerge.org/
[meld-screenshot]: https://github.com/samposm/git-guide/blob/master/images/meld-screenshot.png

## Going Back in Time

## `git checkout`

Using the repository we made above, we now have

```sh
git lg
```

    * ac2e1a2 (HEAD, master) Add new file: b.txt
    * ffdabdc Edit a.txt
    * d7b4272 First commit: add a.txt

If you want to overwrite `a.txt` by a previous version, you can

```sh
git checkout d7b4272 a.txt
```

(In this case, also `HEAD~2` would be the same as `d7b4272`.)

You can also overwrite all tracked files to the state the project was at
in commit `d7b4272` by

```sh
git checkout d7b4272
```

If you have uncommitted changes in some tracked files (staged or not staged),
git will warn you about this and abort. So make sure you have committed all the
changes, so `git status` is clean. (It's ok to have untracked files, they will
not be harmed. ...And even if in some weird situation they were about to be
harmed, `git ckeckout` without the `--force` option will warn and abort, not
overwrite your files. For example: you had a file in some older commits, then
you removed the file from the project in later commits, then you create a file
with the same name again in the working directory. Now, as far as git is
concerned, `git status` will show this file as untracked. But if you checkout
some of those older commits with `--force`, the file will be overwritten.)

So, you can let all the uncommitted changes (both staged and not staged)
to be destroyed by

```sh
git checkout --force d7b4272
```

(Also just `-f` works as short for `--force` here.)

You can look at files, compile, test, and do whatever. To get back to the most
recent commit, do

```sh
git checkout master
```

or, if you changed some of the tracked files while you were testing and looking
around, but are ok to let these changes to be overwritten, do

```sh
git checkout --force master
```

You can go back to any of the old commits, play around as much as you like, and
in the end `git ckeckout master` or `git checkout --force master` will always
bring you back up to date to the most recent commit.

Now I need to make two delicate points: First, please go back to the most
recent commit by referring to it by `master`, not by referring to it by its
hash (which in my case here is `ac2e1a2`). I will explain why in a later
chapter.

Second, if you are in an older commit ...for example if I do

```sh
git checkout -f ffdabdc
```

to get to the second commit ...and then you look at the git log in the default
form, or in any form without the option `--all`, you might get scared.

If I use

```sh
git log --all --graph --decorate --oneline
```

    * ac2e1a2 (master) Add new file: b.txt
    * ffdabdc (HEAD) Edit a.txt
    * d7b4272 First commit: add a.txt

all is well. (`HEAD` points to the commit we are at, after the checkout.)
But if I look at the log without `--all`

```sh
git log --graph --decorate --oneline
```

    * ffdabdc (HEAD) Edit a.txt
    * d7b4272 First commit: add a.txt

OMG! GIT ATE MY WORK! No it didn't. For some reason, by default the log only
shows commits preceding the commit we have checked out. By adding the `--all`
to the log command, we get a list of the full log. (Or, full log of commits in
our `master` branch here, to be exact.)


## What's Next?

Now we can add commits to our project in a linear fashion. Next we should learn
how to keep alternative lines of work in separate branches in a single repo,
how to keep our local repo in sync with one or several remotes, and how to work
together with other people by pulling their commits into our own repo.

But I don't really feel that it is possible to meaningfully explain how to work
with several branches, modify, reorganize and merge them, without first
exposing something about git's internal representation of these things.
