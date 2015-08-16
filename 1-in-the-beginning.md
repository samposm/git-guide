# 1 In the Beginning

## Version Control

Git is a version control system. Mostly used by programmers, but it can be useful
in any kind of incremental work with text files, and to some extent other than
text files, too. Whenever you feel like it, you can save a snapshot of your
work. Git will save the contents of your files, time and date, your name (you
can use a nickname), and a comment (as short or as long as you like) to describe
this snapshot. Later you can go back and view older snapshots, compare
differences between them, and go back to an older version and start over from
that, if you feel some of the later additions have been a bad idea. Or just go
back to an older version and start over to test a different idea. Git will keep
both lines of work stored, you just have created a branching project history
but that's ok.

Actually, the full power of Git only comes about in a cooperative project of
several (or several hundred) people, where people can work simultaneously on the
same project, and snapshots are created, shared, discussed, compared, and thrown around like no tomorrow.

## Install Git

You might already have git installed. Try

```sh
git
```
to find out. If you have git, it prints a small help message.

**Ubuntu**: Type

```sh
sudo apt-get install git
```

to install git. You need the sudo password.

**Fedora**:

```sh
    sudo yum install git
```

## Introduce Yourself

With a text editor, create a file `.gitconfig` in your home directory, and put there

    [user]
        name = Your Name
        email = your@email
    [core]
        editor = gedit

(You could also use a nickname.) When you work with others, they will see this name to identify your work. Instead of gedit, put in your favorite editor.
