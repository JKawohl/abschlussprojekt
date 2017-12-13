#!/bin/bash
zypper refresh
zypper addrepo --no-gpgcheck http://download.opensuse.org/repositories/isv:ownCloud:community:testing/openSUSE_Leap_42.3/isv:ownCloud:community:testing.repo
zypper install -y owncloud-client
. /etc/os-release 

(owncloudcmd --version | grep -q "ownCloud version" && echo "SUCCESS: version $(owncloudcmd --version | head -1) installed! System: $PRETTY_NAME" || echo "FAIL: ownCloud not installed\! ") >> /logs/desktop.install.log 2>&1
