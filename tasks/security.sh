#!/bin/bash

#Variables containing output messages
minimal='*******Minimal security update running*******'
full='*******Full security update running*******'

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
