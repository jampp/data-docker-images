# Note: This Dockerfile is based on https://hub.docker.com/r/johannestang/hadoop-base
FROM openjdk:8-slim

ARG BUILD_VERSION
ARG HADOOP_VERSION=3.2.1

LABEL org.opencontainers.image.description="Hadoop ${HADOOP_VERSION} base image"
LABEL org.opencontainers.image.title="public.ecr.aws/jampp/hadoop"
LABEL org.opencontainers.image.vendor="Jampp"
LABEL org.opencontainers.image.authors="Data Infrastructure Team <data-infra@jampp.com>"
LABEL org.opencontainers.image.url="https://github.com/jampp/data-docker-images"
LABEL org.opencontainers.image.version=$BUILD_VERSION

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends net-tools curl netcat gnupg && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN curl -L https://dist.apache.org/repos/dist/release/hadoop/common/KEYS -o /tmp/KEYS && \
    gpg --import /tmp/KEYS

ARG HADOOP_URL=https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1

ENV USER=root
ENV PATH=$HADOOP_PREFIX/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
