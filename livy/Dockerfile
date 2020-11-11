FROM docker.jampp.com/spark-base:spark-2.4.4-hive-2.3.6-hadoop2.8.5-java8

# Create folder for Livy source files
RUN mkdir -p /src/livy
WORKDIR /src/livy

# Download Livy source files
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://downloads.apache.org/incubator/livy/0.7.0-incubating/apache-livy-0.7.0-incubating-bin.zip  && \
    unzip apache-livy-0.7.0-incubating-bin.zip && \
    rm apache-livy-0.7.0-incubating-bin.zip && \
    apt-get --purge remove -y wget unzip && \
    apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Install dependencies for Wolfria's spark_cli
RUN pip3 install toml jinja2 && \
    pip3 install -U -i https://pypi.jampp.com/pypi datacommon[silver_client]

# Copy the local config file to the container
COPY ./livy.conf /src/livy/apache-livy-0.7.0-incubating-bin/conf/

# Set the Livy logs folder and start the server
SHELL ["/bin/bash", "-c"]
RUN mkdir -p /src/livy/apache-livy-0.7.0-incubating-bin/logs
CMD ["/src/livy/apache-livy-0.7.0-incubating-bin/bin/livy-server"]
