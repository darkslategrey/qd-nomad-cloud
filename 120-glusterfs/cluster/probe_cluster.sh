#!/bin/bash
# Create GlusterFS cluster

# Get settings from the file
source settings

#
gcloud config set project ${PROJECT}

echo " "
echo "Configure the trusted pool ..."
for (( i=2; i<=${COUNT}; i++ ))
do
    echo "Configure the trusted pool for ${SERVER}-${i} ..."
    gcloud compute ssh --zone ${REGION}-${ZONES[0]} ${SERVER}-1 --command "sudo gluster peer probe ${SERVER}-${i}"
done

echo " "
echo "The end ..."
