#!/usr/bin/env bash

case "${1}" in

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

set -eu

# Initialize Airflow
airflow initdb

# Start Scheduler
airflow scheduler &

# Start webserver
exec airflow "$@"
