# Note: This Dockerfile is based on https://hub.docker.com/r/johannestang/hadoop-namenode

FROM docker.jampp.com/hadoop-base:hadoop2.8.5-java8

LABEL com.jampp.maintainer="Data Infrastructure Team <data-infra@jampp.com>"
LABEL com.jampp.description="Hadoop namenode image"

HEALTHCHECK CMD curl -f http://localhost:50070/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 50070

CMD ["/run.sh"]
