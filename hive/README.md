# Apache Hive

## Configuration

The files found in the [conf directory](./conf/) are mounted to a volume, so anything that you change there will be reflected in the container.

The connection to MinIO in particular, is found in the [hadoop-hive.env](./hadoop-hive.env) file and can be changed with environment variables in [docker-compose](../docker-compose.yml)


## Running queries

To connect to the Hive Server service in the container and perform queries, run the [beeline.sh](./beeline.sh) script.