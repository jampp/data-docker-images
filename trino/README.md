# Trino

This service uses [Trino](https://trino.io/)'s (formerly PrestoSQL) [official image](https://hub.docker.com/r/trinodb/trino).


## Configuration

The files found in the [conf directory](./conf/) are mounted to a volume, so anything that you change there will be reflected in the container.

The connection to MinIO in particular, is found in the [hive.properties](./conf/catalog/hive.properties) file.


## Running queries

To run interactive queries through the Trino CLI, run the following command:

```bash
docker-compose exec trino trino --catalog hive --schema default
```
