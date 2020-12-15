#!/usr/bin/env bash

# Get paths to migration files
source ./table_names.sh

# Get file paths to download into minio
if [ ${#TABLE_NAMES[@]} -eq 0 ]; then
    echo "\$TABLE_NAMES is empty."
else
    echo "Creating partitions..."
    for p in "${TABLE_NAMES[@]}"
    do
        export SQL_TO_DO="$SQL_TO_DO MSCK REPAIR TABLE $p;"
    done
    echo "$SQL_TO_DO"
fi

/opt/hive/bin/beeline -u jdbc:hive2://hive-server:10000 -e "$SQL_TO_DO;"
