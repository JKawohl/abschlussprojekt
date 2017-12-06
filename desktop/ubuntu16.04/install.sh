#!/bin/bash
apt-get update
apt-get install -y sudo
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_16.04/ /' > /etc/apt/sources.list.d/owncloud-client.list"
sudo apt-get update
sudo apt-get -y install owncloud-client