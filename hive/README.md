# Apache Hive

## Configuration

The files found in the [conf directory](./conf/) are mounted to a volume, so anything that you change there will be reflected in the container.

The connection to MinIO in particular, is found in the [hadoop-hive.env](./hadoop-hive.env) file and can be changed with environment variables in [docker-compose](../docker-compose.yml)


## Running queries

To connect to the Hive Server service in the container and perform queries, run the [beeline.sh](./beeline.sh) script.

## Creating partitions in bulk

For this service to work is expected that data has been already downloaded to MinIO, it is possible to do it manually, but this project has a way automate that with [download_s3_data](../minio/download_s3_data/download_s3_data.sh). Check [MinIO](../minio/README.md) section for more information on how to do it.
Now, once the data is downloaded/created in MinIO, set the tables that you want to have partitions inserted in [table_names.txt](./create_partitions/table_names.txt) and then run the [create_partitions](../docker-compose.yml#create_partitions) service.
