#
# Trash management for bash
#
# Author: Dave Eddy <dave@daveeddy.com>
# Date: July 02, 2014
# License: MIT

TRASH_DIR=~/.Trash
mkdir -p "$TRASH_DIR"

# trash each argument, or show the state of the trash if no
# arguments are given
trash() {
	# list trash dir if no arguments given
	if [[ -z $1 ]]; then
		if _bash_trash_is_empty; then
			echo "$TRASH_DIR: trash is empty"
		else
			# TODO: GNU du dep required to print the total
			du -csh "$TRASH_DIR"/*
		fi
		return
	fi

	# loop each argument and move to the trash
	local f
	for f in "$@"; do
		local b=$(basename "$f") # basename is sane here, ${f##*/} isn't
		local fname=$b
		local i=1
		while [[ -e $TRASH_DIR/$fname ]]; do
			fname=$b.$i
			((i++))
		done
		mv "$f" "$TRASH_DIR/$fname"
	done
}

# empty the trash
emptytrash() {
	command rm -rf "$TRASH_DIR"/*
}

# return 0 if the trash dir is empty
_bash_trash_is_empty() {
	(
	shopt -s nullglob
	files=("$TRASH_DIR"/*)
	[[ -z ${files[0]} ]]
	)
	return $?
}
