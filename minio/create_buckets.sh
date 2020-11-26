#!/usr/bin/env bash

source ./migration_paths.sh

/usr/bin/mc config host add myminio http://minio:9000 minio_user minio_key;

if [ ${#BUCKETS[@]} -eq 0 ]; then
    echo "\$BUCKETS is empty."
else
    echo "Creating MinIO buckets..."
    for b in "${BUCKETS[@]}"
    do
        /usr/bin/mc mb myminio/${b}
    done
fi
