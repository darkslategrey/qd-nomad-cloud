# Courseur devops

This project is used to build the courseur cloud infra into gcp (Google Cloud
Plateform).

## What do you need to run it?

* Packer (Hashicorp)
* Terraform (Hashicorp)
* acme.sh (https certificates)
ref: (https://github.com/Neilpang/acme.sh/wiki/How-to-use-OVH-domain-api)[https://github.com/Neilpang/acme.sh/wiki/How-to-use-OVH-domain-api]

  (https://github.com/Neilpang/acme.sh)[https://github.com/Neilpang/acme.sh]
  wildcard certificates with ovh :
  1/ got to https://eu.api.ovh.com/createApp/ to get app key / app secret
  2/ export keys 
  `$ export OVH_AK=""`
  `$ export OVH_AS=""`

  3/ `acme.sh  --issue -d cloud.courseur.com  -d '*.cloud.courseur.com'  --dns
  dns_ovh`
  4/ will ask you to go to the authentication link
  5/ rerun `acme.sh`` command. You get something like :
  ```
  Your cert is in  /home/greg/.acme.sh/cloud.courseur.com/cloud.courseur.com.cer 
  Your cert key is in  /home/greg/.acme.sh/cloud.courseur.com/cloud.courseur.com.key 
  The intermediate CA cert is in  /home/greg/.acme.sh/cloud.courseur.com/ca.cer 
  And the full chain certs is there:  /home/greg/.acme.sh/cloud.courseur.com/fullchain.cer 
```
