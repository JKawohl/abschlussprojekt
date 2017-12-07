#!/bin/bash
yum -y update
yum install -y wget 
cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/isv:ownCloud:desktop/CentOS_7/isv:ownCloud:desktop.repo
yum install -y owncloud-client