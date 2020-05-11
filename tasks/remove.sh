#!/bin/bash

#Variables containing output messages
remove='*******Attempting to remove package*******'

#Removes requested package 
#package: <package>
echo -e "\n$remove\n"
/usr/bin/yum remove -y $PT_package
echo ""