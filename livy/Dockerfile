ARG BUILD_VERSION
ARG SPARK_VERSION=3.1.2

FROM public.ecr.aws/jampp/spark:${BUILD_VERSION}

ARG LIVY_VERSION=0.8.0-incubating-SNAPSHOT
ENV LIVY_VERSION=${LIVY_VERSION}
ARG SPARK_VERSION

LABEL org.opencontainers.image.description="Livy ${LIVY_VERSION} with Spark ${SPARK_VERSION}"
LABEL org.opencontainers.image.title="public.ecr.aws/jampp/livy"
LABEL org.opencontainers.image.vendor="Jampp"
LABEL org.opencontainers.image.authors="Data Infrastructure Team <data-infra@jampp.com>"
LABEL org.opencontainers.image.url="https://github.com/jampp/data-docker-images"
LABEL org.opencontainers.image.version=$BUILD_VERSION

# Create folder for Livy source files
RUN mkdir -p /src/livy
WORKDIR /src/livy

# Download Livy source files
RUN apt-get update && apt-get install -y wget unzip && \
    wget --no-check-certificate --no-proxy https://artifacts.jampp.com.s3.amazonaws.com/livy/apache-livy-${LIVY_VERSION}-bin.zip  && \
    unzip apache-livy-${LIVY_VERSION}-bin.zip && \
    rm apache-livy-${LIVY_VERSION}-bin.zip && \
    apt-get --purge remove -y wget unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the local config file to the container
COPY ./livy.conf /src/livy/apache-livy-${LIVY_VERSION}-bin/conf/
RUN cp $HIVE_HOME/conf/hive-site.xml /src/livy/apache-livy-${LIVY_VERSION}-bin/conf/hive-site.xml

# Set the Livy logs folder and start the server
SHELL ["/bin/bash", "-c"]
RUN mkdir -p /src/livy/apache-livy-${LIVY_VERSION}-bin/logs
CMD ["sh", "-c", "/src/livy/apache-livy-${LIVY_VERSION}-bin/bin/livy-server"]
