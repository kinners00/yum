#!/bin/sh

updateall='*******Attempting to update all packages*******'

#Updates all packages
echo -e "\n$updateall\n"
/usr/bin/yum update -y
echo ""

