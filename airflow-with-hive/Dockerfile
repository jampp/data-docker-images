FROM docker.jampp.com/hadoop-hive:2.3.6 as hive
FROM apache/airflow:1.10.12

ENV AIRFLOW_VERSION=1.10.12
ENV HIVE_VERSION=2.3.6
ENV HADOOP_VERSION=2.8.5

ARG BUILD_DATE
ARG BUILD_VERSION

LABEL org.opencontainers.image.description="Airflow ${AIRFLOW_VERSION} base image with Hive ${HIVE_VERSION}"
LABEL org.opencontainers.image.title="jampp.docker.com/airflow-hive"
LABEL org.opencontainers.image.vendor="Jampp"
LABEL org.opencontainers.image.authors="Data Infrastructure Team <data-infra@jampp.com>"
LABEL org.opencontainers.image.url="https://github.com/jampp/data-docker-images"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.version=$BUILD_VERSION

ARG DEBIAN_FRONTEND=noninteractive
ENV TERM=linux
ENV JAVA_HOME=/usr/local/openjdk-8
ENV HADOOP_HOME=/usr/local/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/usr/local/hive
ENV PATH=${HIVE_HOME}/bin:${PATH}

USER root

RUN apt-get update && \
    apt-get install -y jq && \
    apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Copy resources from other layers
COPY --from=hive $JAVA_HOME          $JAVA_HOME
COPY --from=hive /opt/hive           $HIVE_HOME
COPY --from=hive /opt/hadoop-${HADOOP_VERSION}   $HADOOP_HOME

USER airflow

ENV CONFIG_FILES_PATH=/home/airflow/conf
COPY ./conf/* ${CONFIG_FILES_PATH}/ 
COPY ./entrypoint.sh /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]
CMD ["airflow", "webserver", "-p", "8080"]
