# Presto

This service uses [PrestoSQL](https://prestosql.io/)'s official image.


## Configuration

The files found in the [conf directory](./conf/) are mounted to a volume, so anything that you change there will be reflected in the container.

The connection to MinIO in particular, is found in the [hive.properties](./conf/catalog/hive.properties) file.


## Running queries

To connect to the Presto service in the container, run the [presto-cli.sh](./presto-cli.sh) script,
which'll download the `presto-cli.jar` file.