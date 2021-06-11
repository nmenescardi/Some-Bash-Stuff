#!/bin/bash
exec > /var/log/system_update.log                                                                      
exec 2>&1
 
echo "$(date)"
echo "Updating up all packages"

apt-get -y clean
apt-get -y update
apt-get -y upgrade
apt-get -y --purge autoremove
