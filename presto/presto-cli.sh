#!/usr/bin/env bash
cd "${0%/*}"

PRESTO_VERSION="${PRESTO_VERSION:-346}"
if [ ! -e presto-cli.jar ]; then
    wget https://repo1.maven.org/maven2/io/prestosql/presto-cli/$PRESTO_VERSION/presto-cli-$PRESTO_VERSION-executable.jar -O presto-cli.jar
fi 
java -jar presto-cli.jar --server localhost:8083 --catalog hive --schema default
