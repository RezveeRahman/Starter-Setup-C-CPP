# Starter-Setup-C-CPP
Author: Rezvee Rahman \
Date:   01/10/2026

## About
This file contains a starter kit to build and run C and C++ program. \
We have a basic structure (i.e. include directory, and a source directory) \
and a makefile.

## How to use this project
### Basic Use
If you want to create a new C++/C project then you simply want to copy \
and paste the file project into a directory you'll be using for coding.

#### Commands
build source code to produce an executable.
```bash
$ make build
```

cleans up artifacts produced by the build.
```bash
$ make clean
```

#### Modifying the Make file
You can modify the `makefile` as you please. Here are some resources \
that can help:

- [GNU - Makefile Docs](https://www.gnu.org/software/make/manual/make.html)
- [Makefile cookbook](https://makefiletutorial.com/)
- [MIT - Makefile](https://ocw.mit.edu/courses/1-124j-foundations-of-software-engineering-fall-2000/pages/lecture-notes/gnu_makefile_documentation/)

## Q & A
> ❓ - Why use a `Makefile` instead of a `CMake` file?
>
> ✅ - To put it bluntly it is a matter of preference. It stems from the \
> fact that `Makefiles` are easier to work with. However, The goal is to \
> really just get a simple setup without worrying amd spending time on a \
> build system; just code and build is the goal.
>

> ❓- Does this support Micrsoft Windows (11)?
>
> ✅ - I do not know. If Microsoft Windows supports Linux commands and \
> is POSIX compliant, then maybe. But really I do not know. Maybe in the \
> future I'll figure something out to make it windows compatible.
>

> ❓- Can you use a different compiler instead of `gcc` or `g++`?
>
> ✅ - Yes, the `Makefile` allows you to override a variable. When building \
> the code you can do the following:
>
>```sh
> $ make build CXX=clang++-20 CXX_FLAGS="-Wall -Xanalyzer"
>```
>
> There is an example like this in the makefile.
>
> Also you can do:
>```sh
> $ make build CLANG=true
>```
>