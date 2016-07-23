#!/bin/bash

################################################################################
# deskew.sh
# Deskew and clean up scanned pdf files to improve digital document quality
#
# TODO (160722) - Remove scan noise while looping through each png file
# TODO (160722) - Scale each png to be 11x17
################################################################################

# Loop through pdf files in current directory
pdfs=$(find . -type f -name "*.pdf")
for pdf in $pdfs
do
   # CLI update
   echo $pdf: Converting to png

   # Convert pdf file into png files (one png per pdf sheet)
   convert -quality 90 -density 300 "$pdf" ${pdf%.pdf}.png

   # Loop through png files
   pngs=$(find . -type f -name "*.png")
   for png in $pngs
   do
	  # CLI update
	  echo $png: Deskew and trim

	  # Deskew and trim document
	  convert -deskew 40 -trim $png ${png%.png}-DESKEW.png
   done

   # CLI update
   echo ${pdf%.pdf}-DESKEW.pdf: Importing

   # Convert newly created deskewed back to pdf
   convert "*.png" ${pdf%.pdf}-DESKEW.pdf

   # Clean-up remaining png files
   rm ${pdf%.pdf}*.png

   # CLI update
   echo $pdf: Completed
   echo ""
done
