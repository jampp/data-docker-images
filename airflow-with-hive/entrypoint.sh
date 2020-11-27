#!/usr/bin/env bash

set -eu

init_airflow() {
    airflow initdb
    airflow scheduler &
    airflow variables -i "/opt/airflow/conf/variables.json"

    # Create connections
    /opt/airflow/conf/connections.sh

    # create execution pools
    airflow pool --set etl_tasks 1 'etl tasks pool'
}

case "${1}" in

    'airflow')
        shift
        init_airflow
        exec airflow "${@}"
    ;;

    'bash')
        shift
        exec "/bin/bash" "${@}"
    ;;
    
    'python')
        shift
        exec "python" "${@}"
    ;;

    *)
        exec "${@}"
    ;;

esac
