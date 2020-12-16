#!/usr/bin/env bash

set -eu

/usr/bin/mc alias set s3 $S3_HOST $S3_ACCESS_KEY $S3_SECRET_KEY;
/usr/bin/mc alias set minio $MINIO_HOST $MINIO_ACCESS_KEY $MINIO_SECRET_KEY;

echo "Downloading data..."
grep -v -e "#" -e "^$" file_paths.txt | while read b; do
    /usr/bin/mc cp s3/$p minio/$p
done
