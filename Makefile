build:
	docker build --build-arg BUILD_VERSION=$(cat VERSION) -t public.ecr.aws/jampp/hadoop:$(cat VERSION) hadoop
	docker build --build-arg BUILD_VERSION=$(cat VERSION) -t public.ecr.aws/jampp/hive:$(cat VERSION) hive
	docker build --build-arg BUILD_VERSION=$(cat VERSION) -t public.ecr.aws/jampp/spark:$(cat VERSION) spark
	docker build --build-arg BUILD_VERSION=$(cat VERSION) -t public.ecr.aws/jampp/livy:$(cat VERSION) livy
	docker build --build-arg BUILD_VERSION=$(cat VERSION) -t public.ecr.aws/jampp/hdfs-namenode:$(cat VERSION) hdfs-namenode
	docker build --build-arg BUILD_VERSION=$(cat VERSION) -t public.ecr.aws/jampp/hdfs-datanode:$(cat VERSION) hdfs-datanode
	docker build --build-arg BUILD_VERSION=$(cat VERSION) -t public.ecr.aws/jampp/airflow:$(cat VERSION) airflow

release:
	build
	docker push public.ecr.aws/jampp/hadoop:$(cat VERSION)
	docker push public.ecr.aws/jampp/hive:$(cat VERSION)
	docker push public.ecr.aws/jampp/spark:$(cat VERSION)
	docker push public.ecr.aws/jampp/livy:$(cat VERSION)
	docker push public.ecr.aws/jampp/hdfs-namenode:$(cat VERSION)
	docker push public.ecr.aws/jampp/hdfs-datanode:$(cat VERSION)
	docker push public.ecr.aws/jampp/airflow:$(cat VERSION)
	git tag $(cat VERSION)
	git push --tags
