# Note: This Dockerfile is based on https://hub.docker.com/r/johannestang/hadoop-base
# The following changes have been made:
#
# 1. Use openjdk:8-slim as base image

FROM openjdk:8-slim

LABEL com.jampp.maintainer="Data Infrastructure Team <data-infra@jampp.com>"
LABEL com.jampp.description="Hadoop base image"

ARG DEBIAN_FRONTEND=noninteractive
ENV HADOOP_VERSION=2.8.5

RUN apt-get update && apt-get install -y --no-install-recommends net-tools curl netcat gnupg

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
RUN cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1

ENV PATH=$HADOOP_PREFIX/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
