# MinIO

[MinIO](https://min.io/) is a lightweight object storage, compatible with the S3 API.


## UI

By default in this project, MinIO's UI is bound to http://localhost:9000/minio/

Through the UI, you can browse, create and delete buckets and files.


## Credentials

MinIO is key to the architecture of this project, so most of the services need access to it.

Credentials are defined in the repo's [.env file](../.env).
You can change the access and secret keys there and the changes will automatically be reflected in the other services (you need to restart `docker-compose` if it's already running).


## Bucket creation

Buckets can be created manually through the UI or programatically through the [MinIO client](https://hub.docker.com/r/minio/mc) and AWS CLI.

This project provides automatic bucket creation through the `create_buckets` Docker service, which uses the [script](./create_buckets.sh) and [txt file](buckets.sh) found in this folder.

Overriding the [buckets.txt](./buckets.txt) file in your `docker-compose.override.yml` with your own buckets' names will automatically create them when `docker-compose up` is run.


## Volumes

By default, MinIO's buckets and data are stored in [data-docker-images/data/minio/data](../data/minio/data).
Adding files to the buckets in that folder will immediatelly make them available inside the container.

Data will persist in the volumes through different executions of the container, so you'll need to delete the folders between runs if you don't want that to happen.