#!/bin/bash

################################################################################
# deskew.sh
# Deskew and clean up scanned pdf files to improve digital document quality
#
# TODO (160722) - Remove scan noise while looping through each png file
# TODO (160722) - Scale each png to be 11x17
################################################################################	

# Image variables
density=200
deskew=40
quality=90
downtime=30

# Loop through pdf files in current directory
pdfs=$(find . -type f -name "*.pdf")
for pdf in $pdfs
do
   # CLI update
   echo $pdf: Converting to png

   # Temporary directory to store png files
   tmpdir=/tmp/deskew/$pdf

   # Create temporary directory
   mkdir --parents $tmpdir

   # Convert pdf file into png files (one png per pdf sheet)
   convert -quality $quality -density $density $pdf ${pdf%.pdf}.png

   # Loop through png files sorted by page number
   pngs=$(find . -type f -name "*.png" | sed 's/.\///g' | sort -V)
   for png in $pngs
   do
	  # CLI update
	  echo $png: Deskew and trim

	  # Deskew and trim document
	  convert -deskew $deskew -trim $png ${png%.png}-DESKEW.png
   done

   # CLI update
   echo ${pdf%.pdf}-DESKEW.pdf: Importing

   # Convert newly created deskewed back to pdf
   convert $(echo $(find . -type f -name '*-DESKEW.png' | sed 's/.\///g' | sort -V)) ${pdf%.pdf}-DESKEW.pdf

   # Remove temporary directory and all png files
   rm ${pdf%.pdf}*.png

   # CLI update
   echo $pdf: Completed

   # Sleep between each pdf allowing system to cool
   sleep $downtime
done
