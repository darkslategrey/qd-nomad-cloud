variable "region" {
  default = "europe-west1"
}

variable "network" {
  default = "nomad"
}

variable "subnet" {
  default = "pub"
}


variable "deploy_region" {
  default = [
    "europe-west1"
  ]
}

variable "zones" {
  default = [
      "b",
      "c",
    ]
}

variable "instance_type" {
  default = "f1-micro"
}

variable "image" {
  default = "hashistack-courseur-v2"
}

variable "domain" {
  default = "staging.cloud.courseur.com"
}

variable "cluster_tag_name" {
  default = "consul-cluster"
}
