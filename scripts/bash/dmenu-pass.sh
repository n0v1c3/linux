#!/bin/bash

#===================================================================================================
# a simple dmenu session script
#===================================================================================================

shopt -s nullglob globstar

password_dir=( ~/.ps/ )
password_files=( $password_dir**/*.gpg )
password_files=( "${password_files[@]##*/.password-store/}" )
password_files=( "${password_files[@]%.gpg}" )
password_files=("${password_files[@]/$password_dir/}")

password=$(printf '%s\n' "${password_files[@]}" | dmenu -i -b -p '   ' -fn 'DejaVu Sans Mono:regular:pixelsize=18' -nf '#4794ac' -nb '#0d0e11' -sb '#367c84' -sf '#0d0e11')

pass -c "$password" | head -n 1

exit 0
