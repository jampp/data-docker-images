#!/usr/bin/env bash

set -eu

echo "Creating partitions..."
grep -v -e "#" -e "^$" table_names.txt | while read b; do
    export HIVE_COMMAND="$HIVE_COMMAND MSCK REPAIR TABLE $p;"
done

/opt/hive/bin/beeline -u jdbc:hive2://hive-server:10000 -e "$HIVE_COMMAND;"
