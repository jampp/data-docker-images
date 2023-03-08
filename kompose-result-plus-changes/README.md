# Tutorial, how to run the tests with minikube
### Doesnt quite work yet, but is what we have

You must have minikube installed.

Then you open 4 terminal tabs.

First one runs:
`minikube start; minikube dashboard`
2nd runs:
`minikube tunnel`
3rd runs:
`minikube mount /Users/rama/Desktop/data-docker-images/trino/conf/:/Users/rama/Desktop/data-docker-images/trino/conf/` *ugly i know, but we are developing here, ill clean up later*

### And with the cluster running and ready, we start with the magic.
#### Commands that need to be run once
```
minikube image load jampp/hms-test:3.1.11
# Source:  https://github.com/big-data-europe/docker-hive-metastore-postgresql  but the Dockerfile is changed, to be multiplatform.

minikube image load public.ecr.aws/jampp/hive:3.0.1
minikube image load public.ecr.aws/jampp/hdfs-namenode:2.4.0

# These came straight from data-docker-images
```

#### Comands to add services to our kube cluster
```
# Configmap
kubectl apply -f hive-hadoop-hive-env-configmap.yaml

# Minio
kubectl apply -f minio-service.yaml -f minio-deployment.yaml

# hive-server
kubectl apply -f hive-server-service.yaml -f hive-server-deployment.yaml

# Metastore-standalone
kubectl apply -f hive-metastore-service.yaml -f hive-metastore-deployment.yaml

# Metastore-db-postgres
kubectl apply -f hive-metastore-postgresql-service.yaml -f hive-metastore-postgresql-deployment.yaml

# Namenode needed?
kubectl apply -f namenode-service.yaml namenode-deployment.yaml

# Datanode needed?
kubectl apply -f datanode-deployment.yaml -f datanode-service.yaml

# Trino
kubectl apply -f trino-service.yaml -f trino-claim0-persistentvolumeclaim.yaml -f trino-claim0-persistentvolume.yaml -f trino-deployment.yaml

# CREATE BUCKETS
### Not yet ready, since all of the above must exists in the cluster at once and at peace, and i have yet to achieve that
# TODO:
# up livy
# run migratron
# up silverapi
# run airflow
# Adapt tests to this new environment, maybe even create newones
# idk, sommething else probably
# down
```
