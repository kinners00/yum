#!/bin/bash

#Variables containing output messages
full='*******Full security update running*******'
minimal='*******Minimal security update running*******'
updatecache='*******Updating Cache*******'
cleancache='*******Cleaning Cache*******'
cve='*******Attempting to install requested CVE remediation*******'
advisory='*******Attempting to install requested advisory remediation*******'



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

#Checking securitytype input to determine which type of security update to run | full/minimal
if [[ "$PT_securitytype" == "full" ]]; then
    echo -e "$full\n"
    /usr/bin/yum update -y --security
    echo ""
elif [[ "$PT_securitytype" == "minimal" ]]; then 
    echo -e "$minimal\n"
    /usr/bin/yum update-minimal -y --security
    echo ""
    fi

#Checking cve input to determine which cve remediation should be applied | <cve>
if [[ $PT_cve ]]; then
    echo -e "$cve\n"
    /usr/bin/yum update -y --cve $PT_cve
    echo ""
    fi


#Checking advisory input to determine which advisory remediation should be applied | <advisory>
if [[ $PT_advisory ]]; then
    echo -e "$advisory\n"
    /usr/bin/yum update -y --advisory $PT_advisory
    echo ""
    fi