#!/bin/bash
yum -y update
yum install -y wget 
cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/isv:ownCloud:community:testing/CentOS_7/isv:ownCloud:community:testing.repo
yum install -y owncloud-client