#!/bin/bash
zypper refresh
zypper addrepo --no-gpgcheck https://download.opensuse.org/repositories/isv:ownCloud:community:testing/openSUSE_Leap_42.3/isv:ownCloud:community:testing.repo
zypper install -y owncloud-client