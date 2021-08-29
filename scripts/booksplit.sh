#!/bin/sh

# Some pdfs are scanned with two pages as one. This script is for you if you dislike this.
# But remember this converts the pages to images. Hence might lose searchablity for some pdfs.

mkdir tempo44 && cd tempo44 && echo "Creating a temporary directory... \nNOTE: The pages of the book should be less than 9999 \nExtracting images..."

pdftoppm ../$1 $1 -png && echo "Images extracted \nNow cropping..."

convert *.png -crop 2x1@ out-%04d.png && echo 'Cropping complete \nCreating new PDF'
img2pdf out* --out ../0$1 && echo 'Cropped pdf created. \nNow deleting images...'

cd .. && rm -r tempo44

