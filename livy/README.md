# Apache Spark with Apache Livy

This container runs a Spark server accepting jobs through Livy.

## Configuration

This uses mainly files found in the [spark directory](../spark/) for configuration.

The connection to MinIO in particular, is found in the [spark-defaults.conf](../spark/spark-defaults.conf) file.


## Running PySpark

To connect to Spark in the container through PySpark, run the [pyspark.sh](./pyspark.sh) script.