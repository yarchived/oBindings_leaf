#!/usr/bin/env bash

if [ -d 'LibMounts-1.0' ]; then
    cd 'LibMounts-1.0'
    svn update
else
    svn co 'svn://svn.wowace.com/wow/libmounts-1-0/mainline/trunk' 'LibMounts-1.0'
fi


