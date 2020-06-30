FROM markusma/s6:ubuntu-bionic

# ETCD_VERSION cannot be used because etcd reads it
ENV DOCKERFILE_ETCD_VERSION=3.4.0

RUN cd /tmp \
 && curl -LO https://github.com/coreos/etcd/releases/download/v${DOCKERFILE_ETCD_VERSION}/etcd-v${DOCKERFILE_ETCD_VERSION}-linux-amd64.tar.gz \
 && tar zxf etcd-v${DOCKERFILE_ETCD_VERSION}-linux-amd64.tar.gz \
 && cd etcd-v${DOCKERFILE_ETCD_VERSION}-linux-amd64 \
 && mv etcd etcdctl /usr/local/bin/ \
 && cd / \
 && rm -rf /tmp/etcd-v${DOCKERFILE_ETCD_VERSION}-linux-amd64.tar.gz /tmp/etcd-v${DOCKERFILE_ETCD_VERSION}-linux-amd64

COPY etc/ /etc/

EXPOSE 2379 2380 4001
