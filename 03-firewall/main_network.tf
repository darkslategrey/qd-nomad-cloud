### NETWORK LAYER

resource "google_compute_firewall" "icmp" {
  name    = "icmp"
  network = "${var.network}"

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

# resource "google_compute_firewall" "ssh" {
#   name    = "ssh"
#   network = "${var.network}"

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = ["0.0.0.0/0"]
# }

resource "google_compute_firewall" "bastion_nat" {
  name    = "bastion-nat"
  network = "${var.network}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }

  source_tags = ["nomad-servers", "nomad-clients", "consul-servers", "consul-clients", "consul-cluster"]
  target_tags   = ["bastion"]
}
