VERSION = $(shell cat VERSION)

build:
	docker build --build-arg BUILD_VERSION=$(VERSION) -t public.ecr.aws/jampp/hadoop:$(VERSION) hadoop
	docker build --build-arg BUILD_VERSION=$(VERSION) -t public.ecr.aws/jampp/hive:$(VERSION) hive
	docker build --build-arg BUILD_VERSION=$(VERSION) -t public.ecr.aws/jampp/spark:$(VERSION) spark
	docker build --build-arg BUILD_VERSION=$(VERSION) -t public.ecr.aws/jampp/livy:$(VERSION) livy
	docker build --build-arg BUILD_VERSION=$(VERSION) -t public.ecr.aws/jampp/hdfs-namenode:$(VERSION) hdfs-namenode
	docker build --build-arg BUILD_VERSION=$(VERSION) -t public.ecr.aws/jampp/hdfs-datanode:$(VERSION) hdfs-datanode
	docker build --build-arg BUILD_VERSION=$(VERSION) -t public.ecr.aws/jampp/airflow:$(VERSION) airflow

release: build
	docker push public.ecr.aws/jampp/hadoop:$(VERSION)
	docker push public.ecr.aws/jampp/hive:$(VERSION)
	docker push public.ecr.aws/jampp/spark:$(VERSION)
	docker push public.ecr.aws/jampp/livy:$(VERSION)
	docker push public.ecr.aws/jampp/hdfs-namenode:$(VERSION)
	docker push public.ecr.aws/jampp/hdfs-datanode:$(VERSION)
	docker push public.ecr.aws/jampp/airflow:$(VERSION)
	git tag $(VERSION)
	git push --tags
