# Trino

This service uses [TrinoDB](https://trino.io/)'s (formerly PrestoSQL) [official image](https://hub.docker.com/r/trinodb/trino).


## Configuration

The files found in the [conf directory](./conf/) are mounted to a volume, so anything that you change there will be reflected in the container.

The connection to MinIO in particular, is found in the [hive.properties](./conf/catalog/hive.properties) file.


## Running queries

To connect to the Trino service in the container, run the [trino-cli.sh](./trino-cli.sh) script,
which'll download the `trino-cli.jar` file.