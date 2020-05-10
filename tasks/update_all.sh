#!/bin/sh

cleancache='*******Cleaning Cache*******'
updatecache='*******Updating Cache*******'
updateall='*******Attempting to update all packages*******'

#Checking cache input to determine which type of cache action to perform
#cache: [update, clean]
if [[ "$PT_cache" == "update" ]]; then
    echo -e "\n$updatecache\n"
    /usr/bin/yum clean expire-cache
elif [[ "$PT_cache" == "clean" ]]; then
    echo -e "\n$cleancache\n"
    /usr/bin/yum clean all
    fi

#Updates all packages
echo -e "\n$updateall\n"
/usr/bin/yum update -y
echo ""

