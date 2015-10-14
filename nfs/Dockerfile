FROM debian:jessie

RUN apt-get update && apt-get install -y nfs-kernel-server inotify-tools
RUN mkdir -p /exports

ADD setup /

ADD nfs-common /etc/default/nfs-common
ADD nfs-kernel-server /etc/default/nfs-kernel-server

VOLUME /exports

EXPOSE 111/udp 111/tcp 2049/tcp 2049/udp

ENTRYPOINT ["/setup"]
