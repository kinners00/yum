#!/bin/bash

#Variables containing output messages
updatecache='*******Updating Cache*******'
cleancache='*******Cleaning Cache*******'
cve='*******Attempting to install requested CVE remediation*******'


#Checking cache input to determine which type of cache action to perform
#cache: [update, clean]
if [[ "$PT_cache" == "update" ]]; then
    echo -e "\n$updatecache\n"
    /usr/bin/yum clean expire-cache
    echo ""
elif [[ "$PT_cache" == "clean" ]]; then
    echo -e "\n$cleancache\n"
    /usr/bin/yum clean all
    echo ""
    fi

#Checking cve input to determine which cve remediation should be applied
#cve: <cve>
if [[ $PT_cve ]]; then
    echo -e "$cve\n"
    /usr/bin/yum update -y --cve $PT_cve
    echo ""
    fi