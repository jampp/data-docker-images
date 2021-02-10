# Note: This Dockerfile is based on https://hub.docker.com/r/johannestang/hadoop-hive

ARG HADOOP_VERSION=2.8.5

FROM public.ecr.aws/jampp/hadoop:${HADOOP_VERSION}

ARG HADOOP_VERSION
ARG HIVE_VERSION=2.3.6

# Version that works with minio
ARG AWS_VERSION=1.11.534

ARG BUILD_DATE
ARG BUILD_VERSION

LABEL org.opencontainers.image.description="Hive ${HIVE_VERSION} with Hadoop ${HADOOP_VERSION}"
LABEL org.opencontainers.image.title="public.ecr.aws/jampp/hive"
LABEL org.opencontainers.image.vendor="Jampp"
LABEL org.opencontainers.image.authors="Data Infrastructure Team <data-infra@jampp.com>"
LABEL org.opencontainers.image.url="https://github.com/jampp/data-docker-images"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.version=$BUILD_VERSION

ENV HIVE_HOME=/opt/hive
ENV PATH=$HIVE_HOME/bin:$PATH
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}

WORKDIR /opt

ENV JDBC_POSTGRES_VERSION=42.2.18
#Install Hive and PostgreSQL JDBC
RUN apt-get update && apt-get install -y wget procps && \
	wget https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
	tar -xzvf apache-hive-${HIVE_VERSION}-bin.tar.gz && \
	mv apache-hive-${HIVE_VERSION}-bin hive && \
	wget https://jdbc.postgresql.org/download/postgresql-${JDBC_POSTGRES_VERSION}.jar -O $HIVE_HOME/lib/postgresql-jdbc.jar && \
	rm apache-hive-${HIVE_VERSION}-bin.tar.gz && \
	apt-get --purge remove -y wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Install AWS jars  
RUN curl -L https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/${AWS_VERSION}/aws-java-sdk-${AWS_VERSION}.jar -o ${HADOOP_HOME}/share/hadoop/common/lib/aws-java-sdk.jar && \
curl -L https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/${AWS_VERSION}/aws-java-sdk-core-${AWS_VERSION}.jar -o ${HADOOP_HOME}/share/hadoop/common/lib/aws-java-sdk-core.jar && \
curl -L https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/${AWS_VERSION}/aws-java-sdk-s3-${AWS_VERSION}.jar -o ${HADOOP_HOME}/share/hadoop/common/lib/aws-java-sdk-s3.jar && \
curl -L https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar -o ${HADOOP_HOME}/share/hadoop/common/lib/hadoop-aws.jar

#Custom configuration goes here
ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-env.sh $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD conf/ivysettings.xml $HIVE_HOME/conf
ADD conf/llap-daemon-log4j2.properties $HIVE_HOME/conf

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["entrypoint.sh"]
CMD startup.sh
