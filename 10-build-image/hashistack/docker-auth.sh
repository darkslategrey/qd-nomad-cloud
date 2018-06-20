# This is to get permission to pull private docker images
# from the instance

VERSION=1.4.3
OS=linux  # or "darwin" for OSX, "windows" for Windows.
ARCH=amd64  # or "386" for 32-bit OSs

curl -L "https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${VERSION}/docker-credential-gcr_${OS}_${ARCH}-${VERSION}.tar.gz" \
  | tar xz --to-stdout docker-credential-gcr \
        > /usr/bin/docker-credential-gcloud && chmod +x /usr/bin/docker-credential-gcloud

cd /usr/bin && ln -s docker-credential-gcloud docker-credential-gcp

/usr/bin/docker-credential-gcloud configure-docker

# gcloud auth print-access-token | \
#     docker login -u oauth2accesstoken --password-stdin https://eu.gcr.io

