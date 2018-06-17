variable "region" {
  default = "europe-west1"
}

variable "network" {
  default = "default"
}

variable "subnetwork" {
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
  default = "g1-small"
}

variable "image" {
  default = "hashistack-courseur-v1"
}

variable "domain" {
  default = "cloud.courseur.com"
}

variable "cluster_tag_name" {
  default = "consul-cluster"
}
