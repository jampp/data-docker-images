#!/usr/bin/env bash

# Init db, add pools, variables and connections
create_connections() {
    # Merge default_connections and extra_connections
    connections=`jq -s '.[0] * .[1]' ${CONFIG_FILES_PATH}/default_connections.json ${CONFIG_FILES_PATH}/extra_connections.json`

    # Copy conn_ids to array
    mapfile -t conn_ids < <(echo $connections | jq -r 'keys[]')

    for conn_id in "${conn_ids[@]}"
    do
        # To modify an existing connection it must be deleted and re-added
        airflow connections -d --conn_id $conn_id

        # Build the command this way to avoid optional parameters
        cmd="airflow connections -a --conn_id $conn_id"

        connection=`echo $connections | jq .$conn_id `
        mapfile -t args < <(echo $connection | jq  -r 'keys[]')

        for arg in "${args[@]}"
        do
            cmd+=" --$arg "
            value=`echo $connection | jq .$arg`
            cmd+="$value"
        done

        eval $cmd
    done
}

airflow initdb
airflow variables -i "${CONFIG_FILES_PATH}/variables.json"
airflow pool -i "${CONFIG_FILES_PATH}/pools.json"
create_connections
