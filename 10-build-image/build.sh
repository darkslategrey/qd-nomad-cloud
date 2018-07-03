export GOOGLE_PROJECT=courseur-commons

IAM_ACCOUNT=$(gcloud projects get-iam-policy courseur-commons \
                  | grep developer | head -1 | awk -F':' '{print $2}')

if ! [ -f './key.json' ]; then
    echo get new key
    gcloud iam service-accounts keys create ./key.json \
           --iam-account $IAM_ACCOUNT
fi

echo iam_account $IAM_ACCOUNT project $GOOGLE_PROJECT

# TODO: gives administrateur  instance compute to iam_account
export GOOGLE_APPLICATION_CREDENTIALS=/home/greg/WORK/COURSEUR/devops/infra/10-build-image/hashistack/key_staging.json

packer-io build -force --on-error=cleanup nomad-consul.json
# rm key.json
