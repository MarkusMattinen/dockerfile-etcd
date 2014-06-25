# etcd and supervisord on trusty
FROM markusma/supervisord:trusty
MAINTAINER Markus Mattinen <docker@gamma.fi>

ENV ETCD_VERSION 0.4.1

RUN apt-get update \
 && apt-get install -y golang git \
 && cd /tmp \
 && wget https://github.com/coreos/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz \
 && tar zxf etcd-v$ETCD_VERSION-linux-amd64.tar.gz \
 && cd etcd-v$ETCD_VERSION-linux-amd64 \
 && mv etcd etcdctl /usr/local/bin/ \
 && cd / \
 && rm -rf /tmp/etcd-v$ETCD_VERSION-linux-amd64.tar.gz /tmp/etcd-v$ETCD_VERSION-linux-amd64 \
 && apt-get purge -y golang git \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD config/etc/etcd /etc/etcd
ADD config/init /init
ADD config/etc/supervisor/conf.d/etcd.conf /etc/supervisor/conf.d/etcd.conf

EXPOSE 4001 7001
CMD ["/init"]
