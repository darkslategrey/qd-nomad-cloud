# Cannot use this script. gcp does not allow disk to be mounted rw
# between instances. Replaced by a GlusterFS.

# gcloud beta compute disks create redis-disk-1 \
#        --size 10 \
#        --type pd-standard \
#        --region europe-west1 \
#        --replica-zones europe-west1-b,europe-west1-d


# gcloud beta compute instances attach-disk redis-cluster-9xzx \
    #        --disk redis-disk-1 \
    #        --disk-scope regional


gcloud beta compute instances attach-disk redis-cluster-nmcc \
           --disk redis-disk-1 \
           --disk-scope regional \
           --zone europe-west1-d

