#!/bin/bash
yum update
yum install wget 
cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/isv:ownCloud:desktop/CentOS_7/isv:ownCloud:desktop.repo
yum install owncloud-client