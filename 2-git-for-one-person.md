# 2. Git for One Person

## git init

The simplest case is a one-person workflow. Let's create a new project

```sh
mkdir myproject
cd myproject
git init
```

The `git init` will create a hidden `.git` directory (so, `myproject/.git`)
where git will keep all its stuff. In s strict sense, the `.git` directory is
now a repository, or repo for short. In everyday language, the whole
`myproject` directory, containing both the working files and the `.git`
directory, is a project repository. If you for some reason want your project
directory contain the version history no more, you can just `rm -rf .git` and
the version history is destroyed. Also the `.git` directory contains just
ordinary files, so you can copy, zip or tar either the `.git` directory or the
whole project directory and copy or move it around, and it will still function
as a repository in the new place, wherever you put it.

## git commit

Now we need some files

```sh
<edit> a.txt
git add a.txt
git commit -m'First commit: add a.txt'
```

We create a text file, write some text in it, then we *add* the file to git's
list of files to be committed. Then we save (or commit) a snapshot (or a
commit) of our project. Let's go on

```sh
<edit> a.txt
git add a.txt
git commit -m'Edit a.txt'
```

That `-m` is a short way to add a one-line commit message right in the command
line. We can also write longer commit messages

```sh
<edit> b.txt
git add b.txt
git commit
```

Now git will open your favorite editor, and you can write:

    Add new file: b.txt

    Are two files really better than one? Or perhaps the sweet spot would be
    three files ...Can we have a non-integer number of files?

    # Please enter the commit message for your changes. Lines starting
    # with '#' will be ignored, and an empty message aborts the commit.
    # On branch master
    # Changes to be committed:
    #       new file:   b.txt
    #

Traditionally, we first write a simple one-line description of the commit, then
leave one empty line, and then we can write as long a commit message as we
want. After this, save and exit the editor. The commit is done.

## git log

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
changesets. Say, I am working on a project, and someone else contributes some
important bugfixes. I can take only those commits that contain the piece of
work that they made to edit the codebase to make the bugfixes. I would then
apply only these commits on top my ongoing work. (Actually I might apply them
to the *bottom* of my ongoing work, but we'll come to rebasing in a later
chapter.) In these situations, a linear numbering of commits would be different
for each person, and thus git doesn't attempt to do numbering at all.

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

I like it so much that I make an *alias* for it, by adding this to my
`~/.gitconfig`.

    [alias]
        lg = log --oneline --abbrev-commit --all --graph --decorate

So from now on I can just say `git lg`.

## git help <command>

You can also look at `git help log`, or `man git-log`, to see what kind of
options `log` takes, but the manpage is long.

## git status

Because we just committed above, and have made no new changes, our status is
clean:

```sh
git status
```

    On branch master
    nothing to commit, working directory clean

If we make a new file, git will tell us it sees it, but it will not touch it.

```sh
<edit> x.txt
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
<edit> b.txt
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
  repository. Normal git operations will not touch these files, but there are
  commands like `git clean` which specifically clean the project directory from
  untracked files.

* **Committed:** File has been committed in some previous commit, and has not
  been edited since. The file in the working directory is the same version as in
  the repository.

* **Staged:** You have run `git add` on the file, so the file is staged to be
  committed, but you have not run `git commit` yet. Specifically, the version of
  the file at the moment when you ran `git commit` is staged for the commit.

* **Modified:** File has been modified, and the changes have not been added
  (`git add`) or committed.

Actually, a file can be both staged and modified, if you have further edited
the file after staging it.

## The staging area

Most version control systems don't have the concept of staging. Either a file
is unmodified after the last commit, or it has uncommitted changes, and that's
it. But in git, the process has two steps: first `git add` the files you want
to include in the commit and after you had added all the files, run `git
commit`. The files you stage with `git add` can be a subset of the files you
have edited, and only this subset will be committed. The other modified files
will keep their status as modified. You can add several files in one command
(`git add a.txt b.txt`), and use all normal shell wildcards (`git add *.txt`
etc.). If you have staged a file, and edit it further, you need to stage it
again (run `git add` again) for the new edits to be staged for the next commit.

You can stage all files, *including* previously untracked files, that have been
modified since last commit, by `git add --all`. Or you can stage all modified
files, *excluding* untracked files, by 'git add --update'. Also, `git commit
-a` is a shorthand for `git add --update ; git commit`.

Sometimes the staging area is called *index*.

Some people feel that this extra "holding area" is just an unnecessary
complication. Nothing stops you from adding something like

    acommit = !git add --all && git commit
    ucommit = !git add --update && git commit

to the `[alias]` section of you `.gitconfig`. (The `!` syntax tells git to run
the whole alias as a shell command, so we can use `&&` to combine two commands.)
Well, `git ucommit` does now the same things as `git commit -a`.

Other people like the staging area. For example, you can modify your Makefile,
but then only commit modified code files, as long as you don't `git add` the
modified Makefile. Or, after completing a larger piece of work, you can review
the changes you have made, one file at a time, and add the files to the staging
area as a bookkeeping mechanism: these are the files that I have already
reviewed. Or, after some work modifying several files, you can commit the files
in separate commits, if that fees like a good idea. (Git even allows for
[interactive staging][3], to select only part of the edits to a file to be
staged for the commit.)

[3]: https://git-scm.com/book/en/v2/Git-Tools-Interactive-Staging

## git diff

## git show

## git rm

## git checkout
