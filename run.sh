#! /bin/bash
# call all install.sh scripts

logfile=/logs/install.log


#Server
#ubuntu16.04
docker run -ti -v $(pwd)/server/ubuntu16.04/10.0.4/install.sh:/install.sh -v $(pwd)/logs/:/logs  ubuntu:16.04 sh -s -c install.sh
docker run -ti -v $(pwd)/server/ubuntu16.04/9.1.7/install.sh:/install.sh -v $(pwd)/logs/:/logs  ubuntu:16.04 sh -s -c install.sh
#debian9
docker run -ti -v $(pwd)/server/debian9/10.0.4/install.sh:/install.sh -v $(pwd)/logs/:/logs  debian:9 sh install.sh
docker run -ti -v $(pwd)/server/debian9/9.1.7/install.sh:/install.sh -v $(pwd)/logs/:/logs  debian:9 sh install.sh
#opensuse
docker run -ti -v $(pwd)/server/opensuse/10.0.4/install.sh:/install.sh -v $(pwd)/logs/:/logs  opensuse:42.3 sh install.sh
docker run -ti -v $(pwd)/server/opensuse/9.1.7/install.sh:/install.sh -v $(pwd)/logs/:/logs  opensuse:42.3 sh install.sh
#centos7
docker run -ti -v $(pwd)/server/centos7/10.0.4/install.sh:/install.sh -v $(pwd)/logs/:/logs  centos:7 sh install.sh
docker run -ti -v $(pwd)/server/centos7/9.1.7/install.sh:/install.sh -v $(pwd)/logs/:/logs  centos:7 sh install.sh

#Desktop
#ubuntu16.04
docker run -ti -v $(pwd)/desktop/ubuntu16.04/2.3.4/install.sh:/install.sh -v $(pwd)/logs/:/logs ubuntu:16.04 sh install.sh
docker run -ti -v $(pwd)/desktop/ubuntu16.04/2.4.0/install.sh:/install.sh -v $(pwd)/logs/:/logs ubuntu:16.04 sh install.sh

#debian9
docker run -ti -v $(pwd)/desktop/debian9/2.3.4/install.sh:/install.sh -v $(pwd)/logs/:/logs debian:9 sh install.sh
docker run -ti -v $(pwd)/desktop/debian9/2.4.0/install.sh:/install.sh -v $(pwd)/logs/:/logs debian:9 sh install.sh

#opensuse
docker run -ti -v $(pwd)/desktop/opensuse42.3/2.3.4/install.sh:/install.sh -v $(pwd)/logs/:/logs opensuse:42.3 sh install.sh
docker run -ti -v $(pwd)/desktop/opensuse42.3/2.4.0/install.sh:/install.sh -v $(pwd)/logs/:/logs opensuse:42.3 sh install.sh

#centos7
docker run -ti -v $(pwd)/desktop/centos7/2.4.0/install.sh:/install.sh -v $(pwd)/logs/:/logs centos:7 sh install.sh
docker run -ti -v $(pwd)/desktop/centos7/2.3.4/install.sh:/install.sh -v $(pwd)/logs/:/logs centos:7 sh install.sh















cat $logfile
