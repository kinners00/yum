#!/bin/bash

#Variables containing output messages
install='*******Attempting to install package*******'

#Installs requested package 
#package: <package>
echo -e "\n$install\n"
/usr/bin/yum install -y $PT_package 
echo ""

