#!/usr/bin/env bash
cd "${0%/*}"
docker-compose -f ../docker-compose.yml exec livy /opt/spark/bin/pyspark
