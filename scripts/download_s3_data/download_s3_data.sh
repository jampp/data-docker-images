#!/usr/bin/env bash

# Get paths to files that will be downloaded
source ./file_paths.sh

/usr/bin/mc alias set s3 $S3_HOST $S3_ACCESS_KEY $S3_SECRET_KEY;
/usr/bin/mc alias set minio $MINIO_HOST $MINIO_ACCESS_KEY $MINIO_SECRET_KEY;

# Get file paths to download into minio
if [ ${#S3_FILE_PATHS[@]} -eq 0 ]; then
    echo "\$S3_FILE_PATHS is empty."
else
    echo "Downloading S3 files..."
    for p in "${S3_FILE_PATHS[@]}"
    do
        /usr/bin/mc cp s3/$p minio/$p
    done
fi
