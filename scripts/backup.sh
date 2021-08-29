#!/bin/bash

#Pre-req: Need notify-send

# A shell script I use to backup my important files to my USB and dropbox
# folder.

# Just run the command with no commands to get an help page.

backfolder="$HOME/Dropbox/backup"
while getopts "hudaA:i:U:" o; do case "${o}" in
	a) all=True ;;
	A) archive=$OPTARG ;;
	u) backfolder="/media/akshay/JULIETT" ;;
	U) backfolder="/media/akshay/${OPTARGS}" ;;
	i) path=$(readlink -f $OPTARG) ;;
	*) echo "$(basename "$0") usage:
  -a  all important files
  -u  backup to usb
  -i  backup custom file with same relative path"  && exit 1
esac done


if [ $all ]; then
echo -ne "-------------------------\nBacking up Dotfiles, Programs and Scripts...\n" && rsync -vur --exclude "*.swp" ~/{Dotfiles,Programs,scripts} $backfolder &&
echo -ne "\n-------------------------\nBacking up Latex files...\n" && rsync -vur ~/Texfiles/{*.tex,*.bib,preamble,figures,Images} $backfolder/Texfiles &&
echo -ne "-------------------------\n"
notify-send "BACKUP." "Backup to $backfolder complete"
fi


if [ -n "${path+x}" ]; then
relpath="${path#/home/${USER}/*}"
mkdir -p $backfolder/${relpath%/*} &&
rsync -vua $path $backfolder/$relpath
#new version has --mkpath 
fi

if [ $# -eq 0 ]; then
    echo "No arguments provided
$(basename "$0") usage:
  -a  all important files
  -u  backup to usb Juliett
  -U  backup to custom filepath
  -i  backup file with same relative path"  && exit 1
fi
