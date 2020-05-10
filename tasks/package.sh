#!/bin/bash

#Variables containing output messages

install='*******Attempting to install package*******'
remove='*******Attempting to remove package*******'
update='*******Attempting to update package*******'
updateall='*******Attempting to update all packages*******'
minimal='*******Minimal security update running*******'
updatecache='*******Updating Cache*******'
cleancache='*******Cleaning Cache*******'
cve='*******Attempting to install requested CVE remediation*******'
advisory='*******Attempting to install requested advisory remediation*******'

status

#Checking cache input to determine which type of cache action to perform | update/clean
if [[ "$PT_cache" == "update" ]]; then
    echo -e "\n$updatecache\n"
    /usr/bin/yum clean expire-cache
    echo ""
elif [[ "$PT_cache" == "clean" ]]; then
    echo -e "\n$cleancache\n"
    /usr/bin/yum clean all
    echo ""
    fi

#Checking install input to determine which package to install | update/clean
if [[ "$PT_action" == "install" ]]; then
    echo -e "\n$install\n"
    /usr/bin/yum install -y $PT_package 
    echo ""
elif [[ "$PT_action" == "remove" ]]; then
    echo -e "\n$remove\n"
    /usr/bin/yum remove -y $PT_package
    echo ""
elif [[ "$PT_action" == "update" ]]; then
    echo -e "\n$update\n"
    /usr/bin/yum update -y $PT_package
    echo ""
    fi
