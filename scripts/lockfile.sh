#!/bin/bash
# Pre-req : dmenu, open gpg, qpdf
# We need to encrypt files for fun and for safety. This script will help you.


file=$(readlink -f "$1")
ext="${file##*.}"

lockpdf() {
	passwd=$( dmenu -p "Password:" <&-)
    qpdf --encrypt $passwd $passwd 256 -- $1 lock_$1
}

echo $ext
case "$ext" in
	pdf) lockpdf $1;;
	gpg) gpg $1 && rm $1;;
	*) gpg -c --cipher-algo AES256 $1 && rm $1;;
esac

