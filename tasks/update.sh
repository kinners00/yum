#!/bin/bash

#Variables containing output messages
update='*******Attempting to update '$PT_package'*******'

#Updates requested package 
#package: <package>
echo -e "\n$update\n"
/usr/bin/yum update -y $PT_package
echo ""