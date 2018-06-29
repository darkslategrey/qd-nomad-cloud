#!/bin/bash

set -e

exec > >(tee /var/log/startup-script.log|logger -t startup-script -s 2>/dev/console) 2>&1

/opt/consul/bin/run-consul --client --cluster-tag-name "${cluster_tag_name}"

/opt/traefik/bin/run-traefik --domain "${domain}"
