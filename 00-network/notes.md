
# firewall rules default / nomad

NAME                    NETWORK  DIRECTION  PRIORITY  ALLOW                                 DENY
bastion-nat             nomad    INGRESS    1000      tcp:1-65535,icmp,udp:1-65535
consul-clients          nomad    INGRESS    1000      udp:8301,tcp:8300-8301,tcp:8500
consul-servers          nomad    INGRESS    1000      udp:8301-8302,tcp:8300-8302,tcp:8500
consul-traefik          nomad    INGRESS    1000      udp:8301,tcp:8300-8301,tcp:8500
default-allow-icmp      default  INGRESS    65534     icmp
default-allow-internal  default  INGRESS    65534     tcp:0-65535,udp:0-65535,icmp
default-allow-rdp       default  INGRESS    65534     tcp:3389
default-allow-ssh       default  INGRESS    65534     tcp:22
dns                     nomad    INGRESS    1000      udp:53,tcp:53
icmp                    nomad    INGRESS    1000      icmp
ssh                     nomad    INGRESS    1000      tcp:22
traefik                 nomad    INGRESS    1000      tcp:80,tcp:443
traefik-adm             nomad    INGRESS    1000      tcp:8080
