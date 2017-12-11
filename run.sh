#! /bin/bash
# call all install.sh scripts
# Expose Date
echo "Server Test Run: $(date)" >> $(pwd)/logs/server.install.log
echo "Client Test Run: $(date)" >> $(pwd)/logs/desktop.install.log

#Server
#ubuntu16.04
docker run -ti --rm=true -v $(pwd)/server/ubuntu16.04/latestproduction/install.sh:/install.sh -v $(pwd)/logs/:/logs  ubuntu:16.04 sh install.sh
docker run -ti --rm=true -v $(pwd)/server/ubuntu16.04/latest9.1/install.sh:/install.sh -v $(pwd)/logs/:/logs  ubuntu:16.04 sh install.sh
#debian9
docker run -ti --rm=true -v $(pwd)/server/debian9/latestproduction/install.sh:/install.sh -v $(pwd)/logs/:/logs debian:9 sh install.sh
docker run -ti --rm=true -v $(pwd)/server/debian9/latest9.1/install.sh:/install.sh -v $(pwd)/logs/:/logs  debian:9 sh install.sh
#opensuse42.3
docker run -ti --rm=true -v $(pwd)/server/opensuse/latestproduction/install.sh:/install.sh -v $(pwd)/logs/:/logs  opensuse:42.3 sh install.sh
docker run -ti --rm=true -v $(pwd)/server/opensuse/latest9.1/install.sh:/install.sh -v $(pwd)/logs/:/logs  opensuse:42.3 sh install.sh
#centos7
docker run -ti --rm=true -v $(pwd)/server/centos7/latestproduction/install.sh:/install.sh -v $(pwd)/logs/:/logs  centos:7 sh install.sh
docker run -ti --rm=true -v $(pwd)/server/centos7/latest9.1/install.sh:/install.sh -v $(pwd)/logs/:/logs  centos:7 sh install.sh

#Desktop
#ubuntu16.04
docker run -ti --rm=true -v $(pwd)/desktop/ubuntu16.04/production/install.sh:/install.sh -v $(pwd)/logs/:/logs ubuntu:16.04 sh install.sh
docker run -ti --rm=true -v $(pwd)/desktop/ubuntu16.04/testing/install.sh:/install.sh -v $(pwd)/logs/:/logs ubuntu:16.04 sh install.sh
#debian9
docker run -ti --rm=true -v $(pwd)/desktop/debian9/production/install.sh:/install.sh -v $(pwd)/logs/:/logs debian:9 sh install.sh
docker run -ti --rm=true -v $(pwd)/desktop/debian9/testing/install.sh:/install.sh -v $(pwd)/logs/:/logs debian:9 sh install.sh
#opensuse42.3
docker run -ti --rm=true -v $(pwd)/desktop/opensuse42.3/production/install.sh:/install.sh -v $(pwd)/logs/:/logs opensuse:42.3 sh install.sh
docker run -ti --rm=true -v $(pwd)/desktop/opensuse42.3/testing/install.sh:/install.sh -v $(pwd)/logs/:/logs opensuse:42.3 sh install.sh
#centos7
docker run -ti --rm=true -v $(pwd)/desktop/centos7/production/install.sh:/install.sh -v $(pwd)/logs/:/logs centos:7 sh install.sh
docker run -ti --rm=true -v $(pwd)/desktop/centos7/testing/install.sh:/install.sh -v $(pwd)/logs/:/logs centos:7 sh install.sh

cat $(pwd)/logs/server.install.log
cat $(pwd)/logs/desktop.install.log    
