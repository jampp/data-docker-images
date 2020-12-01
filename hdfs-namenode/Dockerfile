# Note: This Dockerfile is based on https://hub.docker.com/r/johannestang/hadoop-namenode

FROM jampp/hadoop:2.8.5

ARG HADOOP_VERSION=2.8.5

ARG BUILD_DATE
ARG BUILD_VERSION

LABEL org.opencontainers.image.description="Hadoop ${HADOOP_VERSION} namenode"
LABEL org.opencontainers.image.title="jampp.docker.com/hdfs-namenode"
LABEL org.opencontainers.image.vendor="Jampp"
LABEL org.opencontainers.image.authors="Data Infrastructure Team <data-infra@jampp.com>"
LABEL org.opencontainers.image.url="https://github.com/jampp/data-docker-images"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.version=$BUILD_VERSION

HEALTHCHECK CMD curl -f http://localhost:50070/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 50070

CMD ["/run.sh"]
