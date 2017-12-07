#!/bin/bash
apt-get update
apt-get install -y sudo
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community:/testing/Ubuntu_16.04/ /' > /etc/apt/sources.list.d/owncloud-client.list"
sudo apt-get update
apt-get --allow-unauthenticated install -y owncloud-client