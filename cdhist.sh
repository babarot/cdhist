###  Name:     cdhist.sh for bash
###  Author:   b4b4r07 <b4b4r07@gmail.com>
###  URL:      https://github.com/b4b4r07/cdhist
###            (see this url for latest release & screenshots)
###  License:  OSI approved MIT license
###  Created:  2013 Sep 03
###  Modified: 
###

[ "$BASH_VERSION" ] || return 1

declare -i CDHIST_CDQMAX=10
declare -r cdhistlist=~/.cdhistlog
declare -a CDHIST_CDQ

function initialize() {
	OLDIFS=$IFS
	IFS=$'\n'
	
	local -a mylist=( $( tail -r $cdhistlist ) )
	local -a temp=()
	local -i i=count=0
	
	for ((i=0; i<${#mylist[*]}; i++)); do
		if ! echo "${temp[*]}" | grep -x "${mylist[i]}" >/dev/null; then
			temp[i]="${mylist[i]}"
			CDHIST_CDQ[$count]="${mylist[i]}"
			let count++
			[ $count -eq $CDHIST_CDQMAX ] && break
		fi
	done
	
	IFS=$OLDIFS
}

function cdhist_reset() {
	CDHIST_CDQ=( "$PWD" )
}

function cdhist_disp() {
	echo "$*" | sed "s $HOME ~ g"
}

function cdhist_add() {
	CDHIST_CDQ=( "$1" "${CDHIST_CDQ[@]}" )
}

function cdhist_del() {
	local i=${1:-0}
	if [ ${#CDHIST_CDQ[@]} -le 1 ]; then return; fi
	for ((; i<${#CDHIST_CDQ[@]}-1; i++)); do
		CDHIST_CDQ[$i]="${CDHIST_CDQ[$((i+1))]}"
	done
	unset CDHIST_CDQ[$i]
}

function cdhist_rot() {
	local i q
	for ((i=0; i<$1; i++)); do
		q[$i]="${CDHIST_CDQ[$(((i+$1+$2)%$1))]}"
	done
	for ((i=0; i<$1; i++)); do
		CDHIST_CDQ[$i]="${q[$i]}"
	done
}

function cdhist_cd() {
	local i f=0
	builtin cd "$@" && ls && pwd >>$cdhistlist || return 1
	for ((i=0; i<${#CDHIST_CDQ[@]}; i++)); do
		if [ "${CDHIST_CDQ[$i]}" = "$PWD" ]; then f=1; break; fi
	done
	if [ $f -eq 1 ]; then
		cdhist_rot $((i+1)) -1
	elif [ ${#CDHIST_CDQ[@]} -lt $CDHIST_CDQMAX ]; then
		cdhist_add "$PWD"
	else
		cdhist_rot ${#CDHIST_CDQ[@]} -1
		CDHIST_CDQ[0]="$PWD"
	fi
}

function cdhist_history() {
	local i d
	[ "$1" -eq 0 ] 2>/dev/null
	[ $? -ge 2 -a "$1" != "" ] && return 1
	if [ $# -eq 0 ]; then
		for ((i=${#CDHIST_CDQ[@]}-1; 0<=i; i--)); do
			cdhist_disp " $i ${CDHIST_CDQ[$i]}"
		done
	elif [ "$1" -lt ${#CDHIST_CDQ[@]} ]; then
		d=${CDHIST_CDQ[$1]}
		if builtin cd "$d" && ls && pwd >>$cdhistlist; then
			cdhist_rot $(($1+1)) -1
		else
			cdhist_del $1
		fi
	fi
}

function cdhist_forward() {
	cdhist_rot ${#CDHIST_CDQ[@]} -${1:-1}
	if ! builtin cd "${CDHIST_CDQ[0]}"; then
		cdhist_del 0
	else
		ls && pwd >>$cdhistlist
	fi
}

function cdhist_back() {
	cdhist_rot ${#CDHIST_CDQ[@]} ${1:-1}
	if ! builtin cd "${CDHIST_CDQ[0]}"; then
		cdhist_del 0
	else
		ls && pwd >>$cdhistlist
	fi
}

#function cd { cdhist_cd "$@" && ls; }
#function + { cdhist_forward "$@" && ls; }
#function - { cdhist_back "$@" && ls; }
#function = { cdhist_history "$@" ; [ $# -eq 0 ] || ls; }
function cd { cdhist_cd "$@"; }
function + { cdhist_forward "$@"; }
function - { cdhist_back "$@"; }
function = { cdhist_history "$@"; }

if [ -f $cdhistlist ]; then
	initialize
	return 0
else
	cdhist_reset
	return 0
fi
