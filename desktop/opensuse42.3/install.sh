#!/bin/bash
zypper refresh
zypper addrepo http://download.opensuse.org/repositories/isv:ownCloud:desktop/openSUSE_Leap_42.3/isv:ownCloud:desktop.repo
zypper refresh
zypper install -y owncloud-client