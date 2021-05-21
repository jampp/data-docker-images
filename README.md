# Data Docker Environment

## Components

* [Apache Airflow](./airflow/README.md)
* [MinIO](./minio/README.md)
* [Apache Hadoop](./hadoop/)
* [HDFS datanode](./hdfs-datanode/)
* [HDFS namenode](./hdfs-namenode/)
* [Apache Hive](./hive/README.md)
* [Apache Spark](./spark/README.md)
* [Apache Livy](./livy/README.md)
* [Trino](./trino/README.md)
* [Migratron](./migratron/README.md)

These components have their own READMEs for setup and configuration instructions.

## Building the images

To build these images for development, you can just run

```bash
docker-compose build <service-name>
```

which will assign the tag specified in the service to the new image, overriding the previous one.


For releasing the images, you should add two variables to the build command:

* `BUILD_DATE`: specifies the date, this can be generated automatically with the command `date -u +'%Y-%m-%dT%H:%M:%SZ'`
* `BUILD_VERSION`: specifies the build version with semantic versioning. *This is not the same as the image's tag*.

This is the build command template:
```bash
docker build ./<image-directory>/ --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg BUILD_VERSION=<version> -t <image-name>:<tag>
```

> Note: when building an image with the `BUILD_DATE` argument, it will always rebuild the image without using Docker's cache, as the argument modifies one of the first layers.


## Running the environment

To run the whole environment:

```bash
docker-compose up -d
```

This environment is resource intensive, though, so you may want to only run the services that you need.
To do so, specify the services' names in the command, for example:

```bash
docker-compose up -d minio airflow livy
```

> Note: some services depend on others to run and the command will fail if those dependencies are not there.


## Using with other projects

One of the most useful parts of this project is being a centralized environment for other projects to use.
Using the [docker-compose override feature](https://docs.docker.com/compose/extends/), we can point to this [docker-compose.yml](./docker-compose.yml) from another project and overwrite only the minimum needed.
To take the most advantage of this feature, you should also use the `docker-compose.volumes.yml` file, that defines common volumes to be used by this projects.

For example, a `docker-compose.override.yml` file in another repository would look like this:

```yml
version: "3"

services:

  # Only specify the components you want to override.
  airflow:
    build: ./
    # For example: an Airflow image with your dependencies pre-installed:
    image: <your-custom-image>:<tag>
    volumes:
     # These volumes will merge with the ones in the base docker-compose file.
     # The ones in the override file take precedence.
     - ${PWD}/dags:/opt/airflow/dags
     - ${PWD}/plugins:/opt/airflow/plugins
     # It's very useful for using your own config files.
     - ${PWD}/docker/airflow/conf/variables.json:/home/airflow/conf/variables.json
     - ${PWD}/docker/airflow/conf/extra_connections.json:/home/airflow/conf/extra_connections.json
     - ${PWD}/docker/airflow/conf/pools.json:/home/airflow/conf/pools.json
    env_file:
     - ${PWD}/docker/airflow/conf/credentials-dev.env
    environment:
      # This variable will be overwritten, but the rest remain the same.
      AIRFLOW__SCHEDULER__STATSD_PREFIX: your-airflow-name

  livy:
    # You can override only the image and it will use all the default configurations
    # found in the base compose file.
    image: <another-custom-image>:<tag>

  create_buckets:
    volumes:
      - ${PWD}/docker/minio/buckets.txt:/buckets.txt

  migratron:
    volumes:
      # Override this file to specify your custom paths
      - ${PWD}/docker/migratron/migration_paths.sh:/migration_paths.sh
      # Mount your migration files directory
      - ${PWD}/db:/db
```

To start the modified environment up, stand in your other project's folder and run:

```bash
PWD=`pwd` docker-compose \
  -f ./path/to/this/repo/docker-compose.yml \
  -f ./docker-compose.volumes.yml \
  -f ./docker-compose.override.yml \
  up -d
```

> Note: when doing this, it's better to use absolute paths on the `docker-compose.override.yml`, that's what the `PWD` assignment is there for in the command (more [here](https://stackoverflow.com/a/50991623)).
