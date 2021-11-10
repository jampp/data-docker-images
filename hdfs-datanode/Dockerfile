# Note: This Dockerfile is based on https://hub.docker.com/r/johannestang/hadoop-datanode
ARG BUILD_VERSION
ARG HADOOP_VERSION=3.2.1

FROM public.ecr.aws/jampp/hadoop:${BUILD_VERSION}

LABEL org.opencontainers.image.description="Hadoop ${HADOOP_VERSION} datanode"
LABEL org.opencontainers.image.title="public.ecr.aws/jampp/hdfs-datanode"
LABEL org.opencontainers.image.vendor="Jampp"
LABEL org.opencontainers.image.authors="Data Infrastructure Team <data-infra@jampp.com>"
LABEL org.opencontainers.image.url="https://github.com/jampp/data-docker-images"
LABEL org.opencontainers.image.version=$BUILD_VERSION

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9864

CMD ["/run.sh"]
