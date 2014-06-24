# etcd and supervisord on trusty
FROM markusma/supervisord:trusty
MAINTAINER Markus Mattinen <docker@gamma.fi>

RUN apt-get update \
 && apt-get install -y golang git

ENV ETCD_VERSION 0.4.1

RUN cd /tmp \
 && wget https://github.com/coreos/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz \
 && tar zxf etcd-v$ETCD_VERSION-linux-amd64.tar.gz \
 && cd etcd-v$ETCD_VERSION-linux-amd64 \
 && mv etcd etcdctl /usr/local/bin/ \
 && rm -rf /tmp/etcd-v$ETCD_VERSION-linux-amd64.tar.gz /tmp/etcd-v$ETCD_VERSION-linux-amd64

ADD config/etc/etcd /etc/etcd
ADD config/init /init
ADD config/etc/supervisor/conf.d/etcd.conf /etc/supervisor/conf.d/etcd.conf

EXPOSE 4001 7001
VOLUME ["/data"]
CMD ["/init"]
