#!/bin/bash
# This script is meant to be run as the Startup Script of each Compute Instance while it's booting. The script uses the
# run-consul script to configure and start Consul in client mode. Note that this script assumes it's running in a Google
# Image built from the Packer template in examples/consul-image/consul.json.

set -e

# Send the log output from this script to startup-script.log, syslog, and the console
# Inspired by https://alestic.com/2010/12/ec2-user-data-output/
exec > >(tee /var/log/startup-script.log|logger -t startup-script -s 2>/dev/console) 2>&1

# These variables are passed in via Terraform template interplation
/opt/consul/bin/run-consul --client --cluster-tag-name "${cluster_tag_name}"

# You could add commands to boot your other apps here


# Courseur custom
echo "set docker auth"
sh -x /usr/local/bin/docker-auth.sh
(! [ -d /root/.docker ] && echo docker auth: NOK) || echo docker auth OK

/opt/nomad/bin/run-nomad --client

sudo /usr/local/bin/cloud_sql_proxy -credential_file=/root/key_staging.json -dir=/cloudsql -instances=courseur-staging:europe-west2:staging-mysql &


sudo systemctl stop glusterfs-server
sudo systemctl disable glusterfs-server

sudo  mount -t glusterfs gluster.service.consul:/redis /mnt
