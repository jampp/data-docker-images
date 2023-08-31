import boto3
import random
from io import BytesIO
import logging

session = boto3.session.Session()
logging.basicConfig(level=logging.INFO)

# Configurando o client de s3 do boto3 para apontar para a app MinIO local
s3_client = session.client(
    service_name='s3',
    aws_access_key_id='minio_user',
    aws_secret_access_key='minio_key',
    endpoint_url='http://localhost:9000',
)

# Checando buckets criados
buckets = [b["Name"] for b in s3_client.list_buckets()["Buckets"]]

# Subindo arquivos dummy
for bucket in buckets:
    file = BytesIO()
    for i in range(10):
        file.write(bytes(str(random.randint(0,100)) + "\n", encoding="utf-8"))
    file.seek(0)
    s3_client.upload_fileobj(file, bucket, "file_random_ints.txt")
    logging.info("Arquivo com números random subido ao bucket %s" % bucket)

# Consumindo arquivos dummy
for bucket in buckets:

    obj = s3_client.get_object(
        Bucket=bucket,
        Key="file_random_ints.txt")

    logging.info("Arquivo com números random lido do bucket %s com a seguinte informação:" % bucket)
    for b in obj['Body']:
        print(str(b, encoding="UTF-8"))