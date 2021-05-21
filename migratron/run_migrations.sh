#!/usr/bin/env bash

set -u

function wait_for_beeline() {
    local retry_seconds=5
    local max_try=100
    (( i=1 ))
    beeline -u 'jdbc:hive2://hive-server:10000/default' -e 'select 1;' > /dev/null 2>&1
    result=$?
    until [ $result -eq 0 ]; do
        echo "[$i/$max_try] check for beeline..."
        echo "[$i/$max_try] beeline is not available yet"
        if (( i == max_try )); then
            echo "[$i/$max_try] beeline is still not available; giving up after ${max_try} tries. :/"
            exit 1
        fi

        echo "[$i/$max_try] try in ${retry_seconds}s once again ..."
        (( i++ ))
        sleep $retry_seconds
        beeline -u 'jdbc:hive2://hive-server:10000/default' -e 'select 1;' > /dev/null 2>&1
        result=$?
    done
    echo "[$i/$max_try] beeline is available."
}

wait_for_beeline
if [ $? -eq 1 ]; then  # Exit if beeline takes too long to init
  exit 1
fi

# Get paths to migration files
source ./migration_paths.sh

if [ -z "$BASE_SCHEMA_PATH" ]; then
    echo "\$BASE_SCHEMA_PATH is empty."
else
    echo "Initializing base schema at ${BASE_SCHEMA_PATH}"
    migratron initialize \
        --just-base-schema \
        --state-db-uri "postgres://hive:hive@hive-metastore-postgresql/metastore" \
        --migrations-path $BASE_SCHEMA_PATH

    if [ $? -eq 1 ]; then
      echo "MigratronDB already initialized, moving along."
    fi
fi

set -e

if [ ${#HIVE_SCHEMA_PATHS[@]} -eq 0 ]; then
    echo "\$HIVE_SCHEMA_PATHS is empty."
else
    echo "Running HIVE migrations..."
    for p in "${HIVE_SCHEMA_PATHS[@]}"
    do
        migratron migrate \
            --state-db-uri "postgres://hive:hive@hive-metastore-postgresql/metastore" \
            --migrations-path $p \
            --db-type hive \
            --db-uri jdbc:hive2://hive-server:10000/ \
            --migration-type any \
            --batch-mode
    done
fi
