#!/usr/bin/env bash

set -eu

case "${1}" in

    'airflow')
        shift
        /init_airflow.sh
        airflow scheduler &
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

    'pytest')
        shift
        /init_airflow.sh
        pytest "${@}"
    ;;

    *)
        exec "${@}"
    ;;

esac
