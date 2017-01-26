#!/bin/sh -e

# Name: git-cache-meta.sh
# Description: git-cache-meta -- simple file meta data caching and applying.
# Simpler than etckeeper, metastore, setgitperms, etc.            
# from http://www.kerneltrap.org/mailarchive/git/2009/1/9/4654694 
# modified by n1k                                                 
#  - save all files metadata not only from other users            
#  - save numeric uid and gid                                     

# 2012-03-05 - added filetime, andris9

: ${cacheMetaFile=$(git rev-parse --show-toplevel)/.git_cache_meta}

case $@ in
    --store|--stdout)
        case $1 in
            --store)
                exec > $cacheMetaFile
                ;;
        esac
        
        find $(git ls-files)\
        \( -printf 'chown %U %p\n' \) \
        \( -printf 'chgrp %G %p\n' \) \
        \( -printf 'touch -c -d "%AY-%Am-%Ad %AH:%AM:%AS" %p\n' \) \
        \( -printf 'chmod %#m %p\n' \)
        ;;

    # Apply the current copy of $git
    --apply)
        sh -e $cacheMetaFile
        ;;
    *)
        1>&2 echo "Usage: $0 --store|--stdout|--apply"
        exit 1
        ;;
esac