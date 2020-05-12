#!/bin/bash

#Variables containing output messages
advisory='*******Attempting to apply '$PT_advisory' remediation*******'

#Checking advisory input to determine which advisory remediation should be applied
#advisory: <advisory>
echo -e "\n$advisory\n"
/usr/bin/yum update -y --advisory $PT_advisory
echo ""
