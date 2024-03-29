# Note: This Dockerfile is based on https://hub.docker.com/r/johannestang/hadoop-hive
ARG BUILD_VERSION
ARG HADOOP_VERSION=3.2.1

FROM public.ecr.aws/jampp/hadoop:${BUILD_VERSION}

ARG HADOOP_VERSION
ARG HIVE_VERSION=3.1.2

# Version that works with minio
ARG AWS_VERSION=1.11.977

LABEL org.opencontainers.image.description="Hive ${HIVE_VERSION} with Hadoop ${HADOOP_VERSION}"
LABEL org.opencontainers.image.title="public.ecr.aws/jampp/hive"
LABEL org.opencontainers.image.vendor="Jampp"
LABEL org.opencontainers.image.authors="Data Infrastructure Team <data-infra@jampp.com>"
LABEL org.opencontainers.image.url="https://github.com/jampp/data-docker-images"
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
curl -L https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar -o ${HADOOP_HOME}/share/hadoop/common/lib/hadoop-aws.jar && \
curl -L https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-dynamodb/${AWS_VERSION}/aws-java-sdk-dynamodb-${AWS_VERSION}.jar -o ${HADOOP_HOME}/share/hadoop/common/lib/aws-java-sdk-dynamodb-.jar

# Install Iceberg jar
RUN curl -L https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-hive-runtime/0.12.1/iceberg-hive-runtime-0.12.1.jar -o ${HADOOP_HOME}/share/hadoop/common/lib/iceberg-hive-runtime-0.12.1.jar

# Updating JAVA libs from Google
RUN rm /opt/hive/lib/guava-19.0.jar && \
	cp /opt/hadoop-3.2.1/share/hadoop/common/lib/guava-27.0-jre.jar /opt/hive/lib/

# Custom configuration goes here
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
