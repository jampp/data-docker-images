#!/usr/bin/env bash

# Init db, add pools, variables and connections

delete_connections() {
    # Merge default_connections and extra_connections
    connections=`jq -s '.[0] * .[1]' ${CONFIG_FILES_PATH}/default_connections.json ${CONFIG_FILES_PATH}/extra_connections.json`

    # Copy conn_ids to array
    mapfile -t conn_ids < <(echo $connections | jq -r 'keys[]')

    for conn_id in "${conn_ids[@]}"
    do
        # To modify an existing connection it must be deleted and re-added
        airflow connections delete $conn_id
    done
}


airflow db init
airflow variables import "${CONFIG_FILES_PATH}/variables.json"
airflow pools import "${CONFIG_FILES_PATH}/pools.json"
delete_connections
airflow connections import "${CONFIG_FILES_PATH}/extra_connections.json"
airflow connections import "${CONFIG_FILES_PATH}/default_connections.json"
