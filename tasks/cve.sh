#!/bin/bash

#Variables containing output messages
cve='*******Attempting to apply '$PT_cve' remediation*******'

#Checking cve input to determine which cve remediation should be applied
#cve: <cve>
echo -e "\n$cve\n"
/usr/bin/yum update -y --cve $PT_cve
echo ""