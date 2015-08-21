# 1. Why

## Why Version Control

Git is a version control system. Mostly used by programmers, but it can be useful in any kind of incremental work with text files, and to some extent other than text files, too. Whenever you feel like it, you can save a snapshot of your work. Git will save the contents of your files, time and date, your name (you can use a nickname), and a comment (as short or as long as you like) to describe this snapshot. Later you can go back and view older snapshots, compare differences between them, and go back to an older version and start over from that, if you feel some of the later additions have been a bad idea. Or just go back to an older version and start over to test a different idea. Git will keep both lines of work stored, you just have created a project with branching history, but that's ok.

If you have something like `proj01`, `proj02`, `proj02new`, `proj02fixed`, `proj03`, `proj03from_alice`, `proj02newfixed_from_bob` directories around, you ~~probably~~ should use version control. Perhaps [watch a simple video][1], or read ["About Version Control"][2] in the [Pro Git][3] book, or ["Why revision control"][4] in the [Mercurial guide][5].

[1]: https://git-scm.com/video/what-is-version-control
[2]: https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control
[3]: https://git-scm.com/book/en/v2
[4]: http://hgbook.red-bean.com/read/how-did-we-get-here.html
[5]: http://hgbook.red-bean.com/read/


The full power of git only comes about in a cooperative project of several (or several hundred) people, where people can work simultaneously on the same project, and snapshots and changes are created, shared, discussed, compared, and thrown around like no tomorrow.

It is important to think more in terms of changesets than in terms of snapshots. A changeset is the set of changes that was made to move from one snapshot to the next one. With git (or any distributed version control system) you can take some changesets from somebody, and apply them to your version of the project. If the starting point in your version is similar to the state of the project those changesets were made on, there should be no problem rolling them on your version.


## Some History

In the Hadean era, there was [RCS][h1] (released in 1982) and [CVS][h2] (1990). The Precambrian era was ruled by [Subversion][h3] (2000). These are *centralized* systems, meaning that to work as a team you need a server to host the system and everyone needs network access to the server.  Then around 2005 we had the Cambrian explosion of *distributed* systems with [darcs][h4], [Monotone][h5], [Bazaar][h6], [git][h7], [Mercurial][h8] suddenly popping up. There also some commercial systems in use. With a distributed system, you are free from setting up servers, and you can work on your version controlled project as easily as working with any files on your laptop. You still need network connection to exchange work with other, just like with files.

Now it's 2015, and everyone uses services like [GitHub][h9] and [Bitbucket][h10] (or perhaps [GibLab][h11] installed on a server with organization-wide access) to host and share their projects. And you get wifi in aeroplanes and 4G in camping trips, so we are sort of back to the centralized model (with the optional freedom of being distributed if we need it). But world was a different place in 2005.

[h1]: https://en.wikipedia.org/wiki/Revision_Control_System
[h2]: https://en.wikipedia.org/wiki/Concurrent_Versions_System
[h3]: https://en.wikipedia.org/wiki/Apache_Subversion
[h4]: https://en.wikipedia.org/wiki/Darcs
[h5]: https://en.wikipedia.org/wiki/Monotone_%28software%29
[h6]: https://en.wikipedia.org/wiki/GNU_Bazaar
[h7]: https://en.wikipedia.org/wiki/Git_%28software%29
[h8]: https://en.wikipedia.org/wiki/Mercurial
[h9]: https://github.com/
[h10]: https://bitbucket.org/
[h11]: https://about.gitlab.com/

## Why git

The experimental diversity of 2005 is over, and only two systems survived: git and Mercurial, with git having maybe 90% market share. So you probably should choose git.

Having said that, in my opinion for simple use you can get up to speed with Mercurial quicker. You need to learn a fair amount of concepts and background before you can use use git without frequent wtf-moments. For Mercurial, the initial learning curve is friendlier. For a power user, the systems are almost identical in features and capabilities, so you can accomplish almost anything using either, if you know how. (One exception: in Mercurial you can permanently store branch name in commits, in git not ...unless you put it informally in the commit message.)

## Why This Guide

Web is full of git tutorials. They set you on a track (Look! Git is easy!) but if you take one or two steps off the track they showed you, you can get lost. I try to cover the track *and* the first bushes, so you can find your way back on the track. Like the infamous “detached HEAD state”, and even if you think you lost commits, `git log -all` still finds them. Or if you lost commits while in a detached head state, you can find them from the reflog.