#!/usr/bin/env bash
#For creating a folder structure to classify files on the YEAR and MONTH.
#Aliased to sortdate

for f in *; do
    FILENAME="$f"
    YEAR=`date -r $f +%Y`
    MONTH=`date -r $f +'%m %B'`
    DEST="$YEAR"/"$MONTH"
    if [ ! -d "$DEST" ]; then
        mkdir -p "$DEST"
    fi
    if ! [ -d "$FILENAME" ]; then
        mv "$FILENAME" "$DEST"
    fi
done
