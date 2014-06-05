# Description

*Cdhist adds 'web-browser like history' to your bash shell.
Every time you change the current directory it records the directory you can go back by simply typing a short command such as '-' or '+', just like clicking web-browsers's 'back' button.
It's more convenient than using directory stacks when you walk around two or three directories.*

# Features

*  supports 3.2 or more bash version

# Installation

**Enable cdhist.sh requires restart your bash**

## Git install

You can clone the repository wherever you want. I like to keep it in `~/github/cdhist`.

	git clone https://github.com/b4b4r07/cdhist.git && cd cdhist && ./install.sh

To update, cd into your local dotfiles repository and then:

	git pull origin master

## Git-free install

To install these dotfiles without Git:

	cd; wget -O - https://github.com/b4b4r07/cdhist/tarball/master | tar xvf -

To update later on, just run that command again.

# Usage

If you install this script, you will be able to run the following command.

## cd

	$ cd [target dir]

This original cd command is almost the same as the default cd command. However, the history of the movement is saved. In addition, I have added the some original options.

* `-a /path/to/dir`

	By entering an ambiguous path, search the directory from the history and move there.

	**For example:**
	
		$ cd -a drop u g
		$ pwd
		/Users/b4b4r07/Dropbox/usr/github

* `-l`

	This option rank the number of movements.
	
	**For example:**
	
		$ cd -l
		 745 ~
		 216 ~/dotfiles
		 140 /usr/local/Cellar/cowsay/3.03/share
		  93 ~/.bash.d
		  91 ~/Dropbox/dotfiles
		  67 ~/dotfiles/.bash.d
		  60 ~/Work

## - (minus command)

This script "cdhist" store the movement history of recent on the ring buffer like queue. It is possible to return to the directory one before like a ring by using this command. It operates in the reverse plus command.

**For example:**
	
	$ pwd
	/Users/b4b4r07
	$ cd Work; cd ../github
	$ -; pwd
	/Users/b4b4r07/Work
	$ -; pwd
	/Users/b4b4r07

## + (plus command)

This script "cdhist" store the movement history of recent on the ring buffer like queue. It is possible to return to the directory one after like a ring by using this command. It operates in the reverse minus command.

**For example:**
	
	$ pwd
	/Users/b4b4r07
	$ cd Work; cd ../github
	$ +; pwd
	/Users/b4b4r07
	$ +; pwd
	/Users/b4b4r07/Work

## = (equal command)

This script "cdhist" store the movement history of recent on the ring buffer like queue. This command displays the ring buffer of the movement history.

**For example:**

	$ =
	 3 ~/dotfiles
 	 2 ~
 	 1 ~/Work
 	 0 ~/github
 	$ +; pwd
 	/Users/b4b4r07/dotfiles
 	$ - 2; pwd
 	/Users/b4b4r07/Work
 
 When you pass a number to the argument of this command, jump to the directory of numbers subscript.
 
 In addition, = (equal command) can narrow the candidate from the list and jump to the directory.
 
 **Demo**
 
 	$ = dr gi
 	 1 ~/Dropbox/usr/github
 	 0 ~/Dropbox/usr/github/cdhist
 	
 If there is only one candidate, go directly to the candidate.
 
 **Demo**
 
 	$ = dr cd
 	$ pwd
 	/Users/b4b4r07/Dropbox/usr/github/cdhist
 
 If you pass a number to the last command line argument, jumping to number of the candidate.
 
 **Demo**
 
 	$ = de
 	 9 ~/Desktop/eigo
	 8 ~/Desktop
	 7 ~/Desktop/sugaku
	 6 ~/Desktop/rika
	$ = dr 9
	$ pwd
	/Users/b4b4r07/Desktop/eigo
 	
 
# Author

| [![twitter/b4b4r07](http://www.gravatar.com/avatar/8238c3c0be55b887aa9d6d59bfefa504.png)](http://twitter.com/b4b4r07 "Follow @b4b4r07 on Twitter") |
|:---:|
| [b4b4r07's Qiita](http://qiita.com/b4b4r07/ "b4b4r07 on Qiita") |

# Licence

> The MIT License (MIT)
> 
> Copyright (c) 2014 b4b4r07
> 
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in
> all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE SOFTWARE.
