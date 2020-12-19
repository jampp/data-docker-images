# Apache Hive

## Configuration

The files found in the [conf directory](./conf/) are mounted to a volume, so anything that you change there will be reflected in the container.

The connection to MinIO in particular, is found in the [hadoop-hive.env](./hadoop-hive.env) file and can be changed with environment variables in [docker-compose](../docker-compose.yml)


## Running queries

To connect to the Hive Server service in the container and perform queries, run the [beeline.sh](./beeline.sh) script.

## Creating partitions in bulk

If you have a Hive External Table (with its data stored in the [MinIO volume](../minio/README.md#volumes)) before being able to query that data you'll need to create the corresponding partitions.

This can be done automatically with [create_partitions](../docker-compose.yml#create_partitions) service.

This service will perform an `MSCK repair table` command on every table listed in  [table_names.txt](./create_partitions/table_names.txt).
To take advantage of this, it's recommended that you override the `table_names.txt` file with one that includes your tables (see [this section on overriding](../README.md#using-with-other-projects)).
