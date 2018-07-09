#!/bin/bash


exec > >(tee /var/log/startup-script.log|logger -t startup-script -s 2>/dev/console) 2>&1

/opt/consul/bin/run-consul --client --cluster-tag-name consul-cluster

sudo mv /opt/consul/config/glusterfs-consul.json.inactive /opt/consul/config/glusterfs-consul.json
sudo supervisorctl restart consul
cluster_ip=$(sudo gcloud compute instances list | grep consul-cluster | head -1 | awk '{ print $4 }')

sudo consul join $cluster_ip

