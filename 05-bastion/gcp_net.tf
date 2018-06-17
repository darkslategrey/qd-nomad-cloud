# VPC specs

# resource "google_compute_network" "nomad" {
#   name = "nomad"
#   project = "${var.gcp_project}"
#   auto_create_subnetworks = "false"
# }

# resource "google_compute_subnetwork" "priv" {
#   name          = "priv"
#   project       = "${var.gcp_project}"
#   ip_cidr_range = "172.27.3.0/26"

#   network       = "${google_compute_network.nomad.self_link}"
# }
