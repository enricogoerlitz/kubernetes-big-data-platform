# Start spark-cluster local

```bash
# Build Docker Image
$ docker build -f engo-spark:3.5.5-py312.Dockerfile -t engo/spark:3.5.5-py312 .
$ docker build --platform=linux/amd64 -f engo-spark:3.5.5-py312.Dockerfile -t engo/spark:3.5.5-py312-amd64 .

$ docker tag engo/spark:3.5.5-py312-amd64 aksdevweuacr.azurecr.io/engo/spark:3.5.5-py312-amd64

$ az acr login --name aksdevweuacr
$ docker push aksdevweuacr.azurecr.io/engo/spark:3.5.5-py312-amd64



# TODO: für ubuntu bauen!
# TODO: nach Registry pushen!
$ docker run --rm engo/spark:3.5.5-py312

$ az acr build \
  --registry aksdevweuacr \
  --image engo/spark:3.5.5-py312 \
  --file engo-spark:3.5.5-py312.Dockerfile \
  .


```