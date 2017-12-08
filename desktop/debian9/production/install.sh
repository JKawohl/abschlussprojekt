#!/bin/bash
expected_client_testing_version=2.3.4
apt-get update
apt-get install -y wget
wget -nv https://download.opensuse.org/repositories/isv:ownCloud:desktop/Debian_9.0/Release.key -O Release.key
apt-key add - < Release.key
apt-get update
echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Debian_9.0/ /' > /etc/apt/sources.list.d/owncloud-client.list 
apt-get update
apt-get --allow-unauthenticated -y install -y owncloud-client
. /etc/os-release 

(owncloudcmd --version | grep -q "$expected_client_testing_version" && echo "SUCCESS: version $(owncloudcmd --version | head -1) installed! System: $PRETTY_NAME" || echo "FAIL: ownCloud not installed\! ") >> /logs/desktop.install.log 2>&1
