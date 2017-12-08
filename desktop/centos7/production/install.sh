#!/bin/bash
yum -y update
yum install -y wget 
cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/isv:ownCloud:desktop/CentOS_7/isv:ownCloud:desktop.repo
yum install -y owncloud-client
. /etc/os-release 

(owncloudcmd --version | grep -q "$expected_client_testing_version" && echo "SUCCESS: version $(owncloudcmd --version | head -1) installed! System: $PRETTY_NAME" || echo "FAIL: ownCloud not installed\! ") >> /logs/desktop.install.log 2>&1