# 2. In the Beginning

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

For other Linuxes, [look here][1].

[1]: http://git-scm.com/download/linux

## Introduce Yourself

With a text editor, create a file `.gitconfig` in your home directory, and write

    [user]
        name = Your Name
        email = your@email
    [core]
        editor = gedit

(You could also use a nickname.) When you work with others, they will see this name to identify your work. Put in your favorite editor in place of gedit.
