#!/bin/bash

# Give a pdf and a text file as input. Add the page no. and title of
# bookmark by separating them with a "tab".
# eg:
# 10	Chapter 1
# 15	Chapter 2

#NB: It is tab which is in between title and page no. not spaces.

# Now run the command with the pdf and test file.


base="${2%.*}"

{
while read y
do
	echo -ne "[/Page ${y%%	*} /Title (${y#*	}) /OUT pdfmark\n"
done < $1

}>temp$1.info


gs -o "$base"-withbmk.pdf   \
   -sDEVICE=pdfwrite   \
    temp$1.info \
 -f $2

rm temp$1.info
