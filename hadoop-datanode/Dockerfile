# Note: This Dockerfile is based on https://hub.docker.com/r/johannestang/hadoop-datanode

FROM docker.jampp.com/hadoop-base:hadoop-2.8.5-java8

LABEL com.jampp.maintainer="Data Infrastructure Team <data-infra@jampp.com>"
LABEL com.jampp.description="Hadoop datanode image"

HEALTHCHECK CMD curl -f http://localhost:50075/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 50075

CMD ["/run.sh"]
