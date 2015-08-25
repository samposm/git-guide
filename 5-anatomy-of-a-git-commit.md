# 5. Anatomy of a git Commit

Create a project directory and initialize

```sh
git init test
cd test
ls .git
```

    branches  config  description  HEAD  hooks  info  objects  refs

The hidded directory `.git` is where git keeps its stuff. Make a file

```sh
$EDITOR file1.txt
cat file1.txt 
```

    Yes. Yes. This is a fertile land and we will thrive.
    We will rule over all this land, and we will call it... this land!

At the core, git a relatively simple key–value store. It calculates a *key* ([SHA-1][1] hash), based on the content of an object, and stores the *value* (the content) using the key as a file name. We can look at the hash:

[1]: https://en.wikipedia.org/wiki/SHA-1

```sh
git hash-object file1.txt
```

    cee51b8aa16ae738ce46946d4e068f07ae315795

(If you put the same text in your file, you should actually get the same SHA-1 hash here as I did.)

```sh
git add file1.txt
ls .git/objects/
```

    ce  info  pack

```sh
ls .git/objects/ce/
```

    e51b8aa16ae738ce46946d4e068f07ae315795

Git used the first two characters of the hash a a directory name, and the rest 38 as the filename.

```sh
git cat-file -p cee51b8
```

    Yes. Yes. This is a fertile land and we will thrive.
    We will rule over all this land, and we will call it... this land!

Let's add one more file, but in a subdirectory:

```sh
mkdir dir
cd dir
$EDITOR file2.txt
cd ..
cat dir/file2.txt
```

    I think we should call it your grave!

```sh
git hash-object dir/file2.txt
```

    9524aade9931ec1c9e3c426ef9b04075e2685ef5

```sh
git add dir/file2.txt
```
Begins with `95`, so we should be able to find...

```sh
ls .git/objects/95/
```

    24aade9931ec1c9e3c426ef9b04075e2685ef5

Yes, there it is. Now let's commit

```sh
git commit -m'This land'
```

Now we have a total of 5 objects:

```sh
find .git/objects/ -type f
```

    .git/objects/ec/25bb10c342ab3237e21fd3638c19d4eacc2d6d
    .git/objects/3c/c47cc86329d8ba394e807d26bb2b4519b01bfe
    .git/objects/95/24aade9931ec1c9e3c426ef9b04075e2685ef5
    .git/objects/ce/e51b8aa16ae738ce46946d4e068f07ae315795
    .git/objects/f2/e4886936b3ff6924c0d0d00f7ab0283b641222

We have a tree object (in git-speak, a tree means a directory) that contains another tree `dir` and a blob (a file) `file1.txt`:

```sh
git cat-file -t 3cc47cc
```
    tree
```sh
git cat-file -p 3cc47cc
```
    040000 tree ec25bb10c342ab3237e21fd3638c19d4eacc2d6d	dir
    100644 blob cee51b8aa16ae738ce46946d4e068f07ae315795	file1.txt

The other tree/directory just contains one blob/file `file2.txt`:

```sh
git cat-file -t ec25bb1
```
    tree
```sh
git cat-file -p ec25bb1
```
    100644 blob 9524aade9931ec1c9e3c426ef9b04075e2685ef5	file2.txt

Then we have the file objects

```sh
git cat-file -t cee51b8
```
    blob
```sh
git cat-file -p cee51b8
```
    Yes. Yes. This is a fertile land and we will thrive.
    We will rule over all this land, and we will call it... this land!
```sh
git cat-file -t 9524aad
```
    blob
```sh
git cat-file -p 9524aad
```
    I think we should call it your grave!

If you put the same text content in the files, used same file and directory names, and if your shell process has similar umask as I have (0002), your blobs and trees should have the same hashes, too. (Git doesn't store file permissions in full detail (only as: regular file, group-writeable file, executable file), and it doesn't keep the permissions of the actual files, but uses the umask from the parent process, i.e. your shell.)

The last object is a commit-object. You will have it under a different hash than I have here. (Unless you have same name, same unix time to the second, and same time zone as I have here.)


```sh
git cat-file -t f2e4886
```
    commit
```sh
git cat-file -p f2e4886
```
    tree 3cc47cc86329d8ba394e807d26bb2b4519b01bfe
    author Sampo Smolander <sampo.smolander@helsinki.fi> 1440120501-0400
    committer Sampo Smolander <sampo.smolander@helsinki.fi> 1440120501 -0400
    
    This land

We can see that the commit object contains a reference to a tree (directory), author information, and the commit message. This is the first commit in our test repo, so it does not contain a reference to its parent (it has no parents). If I edit something and make another commit, it will also have a reference to its parent commit:

    tree ed412f0034a89f6849000fb5b455dd4658f2faf0
    parent f2e4886936b3ff6924c0d0d00f7ab0283b641222
    author Sampo Smolander <sampo.smolander@helsinki.fi> 1440126041 -0400
    committer Sampo Smolander <sampo.smolander@helsinki.fi> 1440126041 -0400
    
    Ah! Curse your sudden but inevitable betrayal!

Later we will also see merge-commits, so a commit can also more than one parent. Even more than two, git also allows for an octopus merge.

So this is how git stores files and commits. We see that git actually does all the work of storing files already when we run `git add`, and then at commit time git only needs to store the tree objects and the commit object, but these are not large files as they mostly contain references to other objects. So even when committing a lot of changes, `git commit` runs in a blast.
