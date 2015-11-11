FROM ubuntu:14.04
MAINTAINER Yoshihiro Misawa <myoshi321go@gmail.com>

ADD http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable /btsync.tar.gz
RUN tar xzf /btsync.tar.gz -C /usr/bin && \
    rm /btsync.tar.gz && mkdir -p /btsync/.sync

EXPOSE 55555
ADD run.sh /run.sh

VOLUME ["/data"]
ENTRYPOINT ["/run.sh"]
