# Note: This Dockerfile is based on https://hub.docker.com/r/bde2020/spark-base
ARG BUILD_VERSION
ARG HIVE_VERSION=3.1.2

FROM public.ecr.aws/jampp/hive:${BUILD_VERSION}

ARG SPARK_VERSION=3.1.2
ARG HADOOP_VERSION=3.2.1

LABEL org.opencontainers.image.description="Spark ${SPARK_VERSION} base image with Hadoop ${HADOOP_VERSION}"
LABEL org.opencontainers.image.title="public.ecr.aws/jampp/spark"
LABEL org.opencontainers.image.vendor="Jampp"
LABEL org.opencontainers.image.authors="Data Infrastructure Team <data-infra@jampp.com>"
LABEL org.opencontainers.image.url="https://github.com/jampp/data-docker-images"
LABEL org.opencontainers.image.version=$BUILD_VERSION

ENV SPARK_CONF_DIR=/spark/conf
ENV SPARK_HOME=/opt/spark
ENV HIVE_HOME=/opt/hive

ENV ENABLE_INIT_DAEMON=true
ENV INIT_DAEMON_BASE_URI=http://identifier/init-daemon
ENV INIT_DAEMON_STEP=spark_master_init

RUN apt-get update && apt-get install -y curl wget python3 python3-setuptools python3-pip && \
    wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.2.tgz && \
    tar -xvzf spark-${SPARK_VERSION}-bin-hadoop3.2.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop3.2 ${SPARK_HOME} && \
    rm spark-${SPARK_VERSION}-bin-hadoop3.2.tgz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Spark 3.1.1 dist comes with an incompatible guava
RUN cp $HIVE_HOME/lib/guava-27.0-jre.jar $SPARK_HOME/jars
RUN rm $SPARK_HOME/jars/guava-14.0.1.jar

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED=1

# Give permission to execute scripts
COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh

RUN mkdir -p ${SPARK_CONF_DIR} && cp $HIVE_HOME/conf/hive-site.xml ${SPARK_CONF_DIR}/hive-site.xml
COPY spark-env.sh $SPARK_CONF_DIR/
COPY spark-defaults.conf $SPARK_CONF_DIR/
COPY core-site.xml $SPARK_CONF_DIR/

RUN ln -s /opt/hive/lib/joda-time-2.9.9.jar /opt/spark/jars/joda-time-2.9.9.jar

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
