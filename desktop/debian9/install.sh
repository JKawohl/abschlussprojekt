#!/bin/bash
apt-get update
apt-get install -y wget
wget -nv https://download.opensuse.org/repositories/isv:ownCloud:desktop/Debian_9.0/Release.key -O Release.key
apt-key add - < Release.key
apt-get update
echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Debian_9.0/ /' > /etc/apt/sources.list.d/owncloud-client.list 
apt-get update
apt-get install -y owncloud-client
