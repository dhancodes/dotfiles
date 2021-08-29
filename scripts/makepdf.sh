#!/bin/sh
#Making pdf from anything.

file=$(readlink -f "$1")
dir=${file%/*}
base="${1%.*}"
ext="${file##*.}"

cd "$dir" || exit 1

textype() { \
	command="pdflatex"
	( head -n5 "$file" | grep -qi 'xelatex' ) && command="xelatex"
 	( head -n1 "$file" | grep -qi 'handout' ) && $command --output-directory="$dir" --jobname="$base""_handout" "\PassOptionsToClass{handout}{beamer} \input{$base}" && bibtex "$base""_handout.aux" 
	$command --output-directory="$dir" "$base" &&
	bibtex "$base".aux
	$command --output-directory="$dir" "$base"
 	( head -n1 "$file" | grep -qi 'handout' ) && $command --output-directory="$dir" --jobname="$base""_handout" "\PassOptionsToClass{handout}{beamer} \input{$base}"
}

mdtype() { \
	command="md1"
	( head -n5 "$file" | grep -qi 'beamer' ) && command="beamer"
	( head -n5 "$file" | grep -qi 'twoside' ) && command="md2"
     	~/scripts/pandoc.sh $1 $command
}

case "$ext" in
	djvu) ddjvu -format=pdf "$1" "$base".pdf;;
     	md) mdtype "$1" ;;
     	ps) ps2pdf "$1";;
	odt) unoconv -f pdf "$1";;
	ods) unoconv -f pdf "$1";;
	doc) unoconv -f pdf "$1";;
	ppt) unoconv -f pdf "$1";;
	pptx) unoconv -f pdf "$1";;
        docx) unoconv -f pdf "$1";;
	txt) enscript -j -p -B --margins=10:10: -X dos -o "$base.ps" "$1" && ps2pdf "$base.ps" "$base.pdf" && rm "$base.ps" ;;
	chm) chm2pdf --book $1 $base.pdf;;
	epub) pandoc -s -t latex $1 -o $base.pdf ;;
	tex) textype "$file" ;;
	bib) pandoc "$file" --csl ieee.csl -s -o "$base".pdf ;;
	*) head -n1 "$file" | grep "^#!/" | sed "s/^#!//" | xargs -r -I % "$file" ;;
esac
