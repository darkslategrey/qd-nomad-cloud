# resource "google_compute_network" "nomad" {
#   name = "nomad"
#   auto_create_subnetworks = "false"
# }

# resource "google_compute_subnetwork" "pub" {
#   name          = "pub"
#   ip_cidr_range = "172.27.3.0/26"
#   network       = "${google_compute_network.nomad.self_link}"
# }

# resource "google_compute_subnetwork" "priv" {
#   name          = "priv"
#   ip_cidr_range = "172.27.3.128/26"
#   network       = "${google_compute_network.nomad.self_link}"
# }

# # resource "google_compute_firewall" "icmp" {
# #   name    = "icmp"
# #   network = "${google_compute_network.nomad.name}"

# #   allow {
# #     protocol = "icmp"
# #   }

# #   source_ranges = ["0.0.0.0/0"]
# # }

# # resource "google_compute_firewall" "ssh" {
# #   name    = "ssh"
# #   network = "${google_compute_network.nomad.name}"

# #   allow {
# #     protocol = "tcp"
# #     ports    = ["22"]
# #   }

# #   source_ranges = ["0.0.0.0/0"]
# # }

# # resource "google_compute_firewall" "bastion_nat" {
# #   name    = "bastion-nat"
# #   network = "${google_compute_network.nomad.name}"

# #   allow {
# #     protocol = "icmp"
# #   }

# #   allow {
# #     protocol = "tcp"
# #     ports    = ["1-65535"]
# #   }

# #   allow {
# #     protocol = "udp"
# #     ports    = ["1-65535"]
# #   }

# #   source_tags = [
# #     "nomad-servers",
# #     "nomad-clients",
# #     "consul-servers",
# #     "consul-clients"
# #   ]
# #   target_tags   = ["bastion"]
# # }
