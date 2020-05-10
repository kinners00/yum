#!/bin/bash

#Variables containing output messages
cleancache='*******Cleaning Cache*******'
updatecache='*******Updating Cache*******'
install='*******Attempting to install package*******'
update='*******Attempting to update package*******'
remove='*******Attempting to remove package*******'



#Checking cache input to determine which type of cache action to perform
#cache: [update, clean]
if [[ "$PT_cache" == "update" ]]; then
    echo -e "\n$updatecache\n"
    /usr/bin/yum clean expire-cache
elif [[ "$PT_cache" == "clean" ]]; then
    echo -e "\n$cleancache\n"
    /usr/bin/yum clean all
    fi

#Checking action & package input to determine requested action and package
#action: [install, remove, update] 
#package: <package>
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
