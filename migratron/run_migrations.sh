#!/usr/bin/env bash

set -eu

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
fi

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

if [ ${#PRESTO_SCHEMA_PATHS[@]} -eq 0 ]; then
    echo "\$PRESTO_SCHEMA_PATHS is empty."
else
    echo "Running PRESTO migrations..."
    for p in "${PRESTO_SCHEMA_PATHS[@]}"
    do
        migratron migrate \
            --state-db-uri "postgres://hive:hive@hive-metastore-postgresql/metastore" \
            --migrations-path $p \
            --db-type presto \
            --db-uri presto-coordinator:8080 \
            --migration-type any \
            --batch-mode
    done
fi
