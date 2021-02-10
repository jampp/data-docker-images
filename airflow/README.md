# Apache Airflow

[Apache Airflow](https://airflow.apache.org/) is an excellent orchestrator for bath worflows.
This image also comes with Apache Hive installed, to allow for queries to be remotelly performed against the Hive-Server Docker service.

## Volumes

Volumes can fulfill several roles in this image:

* Load DAGs for interactive editing
* Load Plugins for interactive editing
* Load credentials
* Load custom configurations

If you want to use the default DAGs and configurations in your image (which can be useful when testing a release build image, for example), comment out the volumes section in [docker-compose.yml](../docker-compose.yml).


## Configuration

There are several configurations that can be automatically loaded when the container starts by overriding the pertinent files and mounting them to a volume.

### Connections

There are some default [connections](https://airflow.apache.org/docs/apache-airflow/stable/concepts.html#connections) to the other services in this project defined [in this json](./conf/default_connections.json).

You can override the [extra_connections.json](./conf/extra_connections.json) file to add your custom connections.

These two files will be merged at startup and the connections will be automatically created by the [entrypoint script](./entrypoint.sh).

### Variables

[Airflow variables](https://airflow.apache.org/docs/apache-airflow/stable/concepts.html#variables) are loaded from the [./variables.json](./conf/variables.json) file.
Override the file with your custom variables, which will be automatically loaded when the container starts up.

### Pools

[Airflow pools](https://airflow.apache.org/docs/apache-airflow/stable/concepts.html#pools) are loaded from the [./pools.json](./conf/pools.json) file.
Override the file with your custom pools, which will be automatically loaded when the container starts up.


## UI

By default, you can find the UI at http://localhost:8080/


## Extending

It's recommended that you override this file (see [this section](../README.md#using-with-other-projects)) with one that includes your Airflow's dependencies, to avoid having to install them each time you start the container up.