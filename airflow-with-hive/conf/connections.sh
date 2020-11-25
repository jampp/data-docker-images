airflow connections -d --conn_id hive_cli_default
airflow connections -a --conn_id hive_cli_default --conn_type hive_cli --conn_host hive-server --conn_port 10000 --conn_schema default --conn_login hive --conn_extra "{\"use_beeline\": true, \"auth\": \"\"}"

airflow connections -d --conn_id metastore_default
airflow connections -a --conn_id metastore_default --conn_type hive_metastore --conn_host hive-metastore --conn_port 9083 --conn_extra "{\"authMechanism\": \"PLAIN\"}"

airflow connections -d --conn_id livy_default
airflow connections -a --conn_id livy_default --conn_type http --conn_host livy --conn_port 8998

airflow connections -d --conn_id aws_default
airflow connections -a --conn_id aws_default --conn_type http --conn_host minio --conn_port 9000 --conn_login minio_user --conn_password minio_key --conn_extra "{\"host\": \"http://minio:9000\"}"

airflow connections -d --conn_id presto_default
airflow connections -a --conn_id presto_default --conn_type presto --conn_host hive-server --conn_port 8083 --conn_schema default --conn_login wolfria

sh /opt/airflow/conf/extra_connections.sh