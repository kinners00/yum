#!/bin/bash

#Variables containing output messages
cleancache='*******Cleaning Cache*******'
updatecache='*******Updating Cache*******'
minimal='*******Minimal security update running*******'
full='*******Full security update running*******'


#Checking cache input to determine which type of cache action to perform
#cache: [update, clean]
if [[ "$PT_cache" == "update" ]]; then
    echo -e "\n$updatecache\n"
    /usr/bin/yum clean expire-cache
elif [[ "$PT_cache" == "clean" ]]; then
    echo -e "\n$cleancache\n"
    /usr/bin/yum clean all
    fi

#Checking securitytype input to determine which type of security update to run
#security: [minimal, full]
if [[ "$PT_security" == "full" ]]; then
    echo -e "\n$full\n"
    /usr/bin/yum update -y --security
    echo ""
elif [[ "$PT_security" == "minimal" ]]; then 
    echo -e "\n$minimal\n"
    /usr/bin/yum update-minimal -y --security
    echo ""
    fi
