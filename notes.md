
## gcloud docker

ref: https://cloud.google.com/container-registry/docs/quickstart
ref: https://cloud.google.com/container-registry/docs/managing

```
docker tag quickstart-image gcr.io/[PROJECT-ID]/quickstart-image:tag1
```

#### login 

```
cat key_staging.json | docker login -u _json_key --password-stdin https://eu.gcr.io
```


#### push

```
docker push eu.gcr.io/rrrework/discourse:v1
```

#### list

```
gcloud container images list --repository=eu.gcr.io/rrrework
```

```
gcloud container images list-tags eu.gcr.io/rrrework/discourse
```
