# Commons

variable "private_key_path" {
  default = "~/.ssh/id_rsa"
}

# GCP Vars

variable "gcp_project" {
  default = "courseur-staging"
}
variable "gcp_user" {
  default = "Courseur"
}

variable "region_gcp" {
  default = "europe-west1"
}

variable "az_gcp" {
  default = ["b"]
}

variable "gcp_instance_type" {
  default = "f1-micro"
}

variable "gcp_image" {
  default = "centos-7-v20170426"
}
