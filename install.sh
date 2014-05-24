#!/bin/bash

INSTALL_DIR=${MASTERD:=~/.bash.d}
INSTALL_FILE=cdhist.sh

if [ "$1" = '-h' -o "$1" = '--help' ]; then
	echo 'Usage: ./install.sh [-h/--help][-R][-s]'
	echo '[-h/--help] show this help'
	echo '[-R]        remove all files about cdhist.sh'
	echo '[-s]        silent mode (not write "source install.sh" to .bashrc)'
fi

if [ "$1" = '-R' ]; then
	cat ~/.bashrc | (rm ~/.bashrc; sed '/cdhist/d' > ~/.bashrc)
	exit
fi

mkdir -p $INSTALL_DIR
cp -f $INSTALL_FILE $INSTALL_DIR

echo 'Please restart your shell'
echo ''
echo 'USAGE:'
echo '------'
echo '- [num]       - return to a directory before one'
echo '+ [num]       - return to a directory after one, if exist'
echo '= [word][num] - list directories like a ring buffer and you can train a candidate to list'
echo ''

test "$1" = '-s' && exit
echo "source $INSTALL_DIR/$INSTALL_FILE" >>~/.bashrc
