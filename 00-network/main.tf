variable "network" {
  default = "nomad"
}

variable "project" {
  default = "courseur-staging"
}

provider "google" {
  region = "europe-west1"
  project = "${var.project}"
}


resource "google_compute_network" "nomad" {
  name = "nomad"
  project = "${var.project}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "pub" {
  name          = "pub"
  project       = "${var.project}"
  ip_cidr_range = "172.27.3.0/26"

  network       = "${google_compute_network.nomad.self_link}"
}

resource "google_compute_subnetwork" "priv" {
  name          = "priv"
  project       = "${var.project}"
  ip_cidr_range = "172.27.3.128/26"
  region        = "europe-west1"

  network       = "${google_compute_network.nomad.self_link}"
  depends_on = ["google_compute_network.nomad"]
}

# resource "google_compute_router" "nomad" {
#   name    = "router-nomad"
#   project = "${var.project}"
#   network = "${google_compute_network.nomad.self_link}"

#   bgp {
#     asn = "${var.bgp_gcp}"
#   }
# }

resource "google_compute_firewall" "traefik" {
  name    = "traefik"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["traefik"]
  depends_on = ["google_compute_network.nomad"]
}

resource "google_compute_firewall" "traefik-adm" {
  name    = "traefik-adm"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_tags = ["bastion"]
  target_tags   = ["traefik"]
  depends_on = ["google_compute_network.nomad"]
}

resource "google_compute_firewall" "consul-traefik" {
  name    = "consul-traefik"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["8300-8301", "8500"]
  }

  allow {
    protocol = "udp"
    ports    = ["8301"]
  }

  source_tags   = [
    "consul-servers", "consul-clients", "consul-traefik", "traefik",
    "consul-cluster"
  ]
  target_tags   = ["consul-traefik", "traefik"]
  depends_on = ["google_compute_network.nomad"]
}

resource "google_compute_firewall" "consul-clients" {
  name    = "consul-clients"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["8300-8301", "8500"]
  }

  allow {
    protocol = "udp"
    ports    = ["8301"]
  }

  source_tags   = [
    "consul-servers",
    "consul-clients",
    "consul-traefik",
    "traefik",
    "consul-cluster"
  ]
  target_tags   = ["consul-clients", "consul-cluster"]
  depends_on = ["google_compute_network.nomad"]
}

# resource "google_compute_firewall" "consul-servers" {
#   name    = "consul-servers"
#   network = "${var.network}"

#   allow {
#     protocol = "tcp"
#     ports    = ["8300-8302", "8500"]
#   }

#   allow {
#     protocol = "udp"
#     ports    = ["8301-8302"]
#   }

#   source_ranges = ["0.0.0.0/0"]
#   target_tags   = ["consul-servers", "consul-cluster"]
#   depends_on = ["google_compute_network.nomad"]
# }

# resource "google_compute_firewall" "dns" {
#   name    = "dns"
#   network = "${var.network}"

#   allow {
#     protocol = "tcp"
#     ports    = ["53"]
#   }

#   allow {
#     protocol = "udp"
#     ports    = ["53"]
#   }

#   source_ranges = ["0.0.0.0/0"]
#   depends_on = ["google_compute_network.nomad"]
# }

# resource "google_compute_firewall" "icmp" {
#   name    = "icmp"
#   project = "${var.project}"
#   network = "${var.network}" # google_compute_network.nomad.name}"

#   allow {
#     protocol = "icmp"
#   }

#   source_ranges = ["0.0.0.0/0"]
#   depends_on = ["google_compute_network.nomad"]
# }

# resource "google_compute_firewall" "ssh" {
#   name    = "ssh"
#   project = "${var.project}"
#   network = "${var.network}"

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = ["0.0.0.0/0"]
#   depends_on = ["google_compute_network.nomad"]
# }

resource "google_compute_firewall" "bastion_nat" {
  name    = "bastion-nat"
  project = "${var.project}"
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

  source_tags = [
    "nomad-servers", "nomad-clients",
    "consul-servers", "consul-clients", "consul-cluster"
  ]
  target_tags   = ["bastion"]
  depends_on = ["google_compute_network.nomad"]
}
