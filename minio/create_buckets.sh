#!/bin/sh

/usr/bin/mc config host add myminio $MINIO_HOST $MINIO_ACCESS_KEY $MINIO_SECRET_KEY

echo "Creating MinIO buckets..."
grep -v "#" buckets.txt | while read b; do
    echo "$b"
    /usr/bin/mc mb myminio/$b
done

