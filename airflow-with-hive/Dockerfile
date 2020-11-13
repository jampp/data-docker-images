FROM docker.jampp.com/hadoop-hive:hive-2.3.6-hadoop-2.8.5-java8 as hive
FROM apache/airflow:1.10.12

LABEL com.jampp.maintainer="Data Infrastructure Team <data-infra@jampp.com>"
LABEL com.jampp.description="Airflow with Hive"

ARG DEBIAN_FRONTEND=noninteractive
ENV TERM=linux
ENV JAVA_HOME=/usr/local/openjdk-8
ENV HADOOP_VERSION=2.8.5
ENV HADOOP_HOME=/usr/local/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/usr/local/hive
ENV PATH=${HIVE_HOME}/bin:${PATH}

USER root

# Copy resources from other layers
COPY --from=hive $JAVA_HOME          $JAVA_HOME
COPY --from=hive /opt/hive           $HIVE_HOME
COPY --from=hive /opt/hadoop-${HADOOP_VERSION}   $HADOOP_HOME

USER airflow

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["webserver", "-p", "8080"]
