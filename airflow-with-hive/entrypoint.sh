#!/usr/bin/env bash

AIRFLOW_COMMAND="${1}"

if [[ ${AIRFLOW_COMMAND} == "bash" ]]; then
   shift
   exec "/bin/bash" "${@}"
elif [[ ${AIRFLOW_COMMAND} == "python" ]]; then
   shift
   exec "python" "${@}"
fi

set -eu

# Initialize Airflow
airflow initdb

# Start Scheduler
airflow scheduler &

# Start webserver
exec airflow "$@"
