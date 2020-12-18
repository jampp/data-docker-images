#!/usr/bin/env bash
HIVE_QUERY=""
echo "Creating partitions..."

for b in $(grep -v -e "#" -e "^$" table_names.txt);
do
    HIVE_QUERY="$HIVE_QUERY MSCK REPAIR TABLE $b;"
done

echo "Query that will be executed: $HIVE_QUERY"

/opt/hive/bin/beeline -u jdbc:hive2://hive-server:10000 -e "$HIVE_QUERY;"
