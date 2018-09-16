#!/bin/bash

# Name: texpdf.sh
# Description: 

basename=$(basename "${1}")
filename="${basename%.*}"
extension="${basename##*.}"

echo "$filename"
echo "$extension"

if [ "${extension}" == "tex" ]; then
    # Create pdf from tex file passed
    latex "$filename".tex
    dvipdfm "$filename".dvi
    firefox "$filename".pdf

    # Remove extra files that were created
    rm "$filename".aux
    rm "$filename".dvi
    rm "$filename".log
else
    # Wrong filetype
    exit 1
fi

# Successful execution
exit 0

