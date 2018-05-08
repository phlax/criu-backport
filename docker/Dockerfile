# phlax/debian-criu
#
# VERSION       0.0.1

ARG BUILD_FROM=debian:stretch-slim


# Root stage
FROM $BUILD_FROM as root

MAINTAINER Ryan Northey <ryan@synca.io>

ARG CRIU_VERSION=3.8.1
ARG RUN_PKGS='libprotobuf-c1 libprotobuf-lite10 libnet1 libnl-3-200 iptables'

ENV DEBIAN_FRONTEND=noninteractive \
    CRIU_VERSION=$CRIU_VERSION

COPY install-run.sh /tmp/install-run.sh
RUN /tmp/install-run.sh

# Build stage
FROM root as builder

ARG BUILD_PKGS='libprotobuf-dev libprotobuf-c-dev libnl-3-dev libcap-dev libnet1-dev'

COPY install-build.sh /tmp/install-build.sh
RUN /tmp/install-build.sh

COPY install-criu.sh /tmp/install-criu.sh
RUN /tmp/install-criu.sh


# App stage
FROM root

# this makes the criu binary available for stretch - runtime libs are also required
# libprotobuf-lite10 libprotobuf-c1 libnl-3-200 libnet1
COPY --from=builder /tmp/criu/criu-$CRIU_VERSION/criu/criu /usr/local/bin/criu
COPY wrapper /usr/local/bin/wrapper

CMD ["bash", "tail", "-f", "/dev/null"]
ENTRYPOINT ["/usr/local/bin/wrapper"]
