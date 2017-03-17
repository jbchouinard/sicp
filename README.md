# SICP Solutions

My solutions to exercises and projects from Structure and Interpretation of
Computer Programs 2nd ed.

Solutions for exercises up to section 2.4 are in the chapter directories.

After that I started organizing the solutions into modules, in the lib directory.
(I've also reorganized much of the code from previous sections in modules.)

The code was tested with MIT/GNU Scheme 9.1.1 on Ubuntu 16.04.

```
sudo apt-get install mit-scheme
```

Most programs depend on schemerc.scm, it must be loaded first.
(It implements a simple module management system.)

```
mit-scheme --load schemerc.scm FILE ...
```

Configure the libpath in schemerc.scm. By default it is `~/.local/lib/scheme`.

The SICP modules are expected to be found in `LIBPATH/sicp`. Copy them there
or set up a symbolic link.

I find it convenient to configure this alias:

```
alias scheme="rlwrap mit-scheme --load ../path/to/schemerc.scm"
```

rlwrap is a readline wrapper, it makes using the REPL much more fun.
