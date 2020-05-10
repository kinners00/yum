#!/bin/bash

#Variables containing output messages
cleancache='*******Cleaning Cache*******'
updatecache='*******Updating Cache*******'
advisory='*******Attempting to install requested advisory remediation*******'


#Checking cache input to determine which type of cache action to perform
#cache: [update, clean]
if [[ "$PT_cache" == "update" ]]; then
    echo -e "\n$updatecache\n"
    /usr/bin/yum clean expire-cache
elif [[ "$PT_cache" == "clean" ]]; then
    echo -e "\n$cleancache\n"
    /usr/bin/yum clean all
    fi

#Checking advisory input to determine which advisory remediation should be applied
#advisory: <advisory>
if [[ $PT_advisory ]]; then
    echo -e "\n$advisory\n"
    /usr/bin/yum update -y --advisory $PT_advisory
    echo ""
    fi
