#!/usr/bin/env sh

# Makes pdfs into images. Best for compressing pdf notes written on write pads.

mkdir tempo44 && cd tempo44 && echo "Creating a temporary directory... \nNOTE: The pages of the book should be less than 9999 \nExtracting images..."

pdftoppm ../$1 $1 -png && echo "Images extracted \nNow parsing pdf..."
img2pdf * --out ../0$1 && echo "Pdf created. \nNow deleting images..."

cd .. && rm -r tempo44
