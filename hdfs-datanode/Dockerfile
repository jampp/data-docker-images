# Note: This Dockerfile is based on https://hub.docker.com/r/johannestang/hadoop-datanode

ARG HADOOP_VERSION=2.8.5

FROM jampp/hadoop:${HADOOP_VERSION}

ARG HADOOP_VERSION
ARG BUILD_DATE
ARG BUILD_VERSION

LABEL org.opencontainers.image.description="Hadoop ${HADOOP_VERSION} datanode"
LABEL org.opencontainers.image.title="jampp/hdfs-datanode"
LABEL org.opencontainers.image.vendor="Jampp"
LABEL org.opencontainers.image.authors="Data Infrastructure Team <data-infra@jampp.com>"
LABEL org.opencontainers.image.url="https://github.com/jampp/data-docker-images"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.version=$BUILD_VERSION

HEALTHCHECK CMD curl -f http://localhost:50075/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 50075

CMD ["/run.sh"]
