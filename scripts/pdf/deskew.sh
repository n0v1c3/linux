#!/bin/bash

################################################################################
#
# deskew.sh
# Deskew and clean up scanned pdf files to improve digital document quality
#
# Instructions:
# - New file in from client
#
# - Deskew
#	- Run this script in the directory with the pdfs needing to be deskewed
#
# - Reorder pdf pages (Bluebeam)
#	- Ensure that all pages are in the same order from the old to the new pdf
#
# - Reduce file size (Bluebeam)
#	- Document->Process->Reduce File Size
#	- Use all default options for reduceing file size
#
# - Remove old pdfs, the following list is all the pdfs that should be remaining
#	- Original
#	- Deskewed and Reduced
#	- Overlay
#	- Stickfile
#
# - Overlay (Bluebeam)
#	- Old: green
#	- New: red
#	- Opacity: 75%
#	- Process: darken (default)
#
# - Manual compare, cloud changes (Bluebeam)
#	- Review old, new, and overlay in side-by-side view
#	- Cloud changes between documents on the overlay document
#
################################################################################
#
# TODO (160722) - Remove scan noise while looping through each png file
# TODO (160722) - Scale each png to be 11x17
# TODO (160724) - Use temporary folder for png files
# TODO (160724) - Add to PATH dir $HOME/.bin
# TODO (160724) - Convert png to monochrome (threshold 0-100)
#
################################################################################

# Loop through pdf files in current directory
pdfs=$(find . -type f -name "*.pdf")
for pdf in $pdfs
do
   # CLI update
   echo $pdf: Converting to png

   # Convert pdf file into png files (one png per pdf sheet)
	convert -quality 90 -density 300 "$pdf" ${pdf%.pdf}.png

	# CLI update
	echo "Deskew and trim:"

   # Loop through png files
   pngs=$(find . -type f -name "*.png" | sed 's/.\///g' | sort -V)
   for png in $pngs
   do
      # CLI update
      echo -n "$png "

      # Deskew and trim document
      convert -deskew 40 -trim $png ${png%.png}-DESKEW.png
   done

   # CLI update
   echo ${pdf%.pdf}-DESKEW.pdf: Importing

   # Convert newly created deskewed back to pdf
   convert $(echo $(find . -type f -name '*-DESKEW.png' | sed 's/.\///g' | sort -V)) ${pdf%.pdf}-DESKEW.pdf

   # Clean-up remaining png files
   rm ${pdf%.pdf}*.png

   # CLI update
	echo "$pdf: Completed"
done
