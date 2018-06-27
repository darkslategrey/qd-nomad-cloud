resource "google_compute_firewall" "nomad-servers" {
  name    = "nomad-servers"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["4646-4648"]
  }

  allow {
    protocol = "udp"
    ports    = ["4648"]
  }

  # source_tags   = ["bastion"]
  source_ranges = ["0.0.0.0/0"]
  # target_tags   = ["nomad-servers"]
  target_tags   = ["consul-cluster"]
}

resource "google_compute_firewall" "nomad-clients" {
  name    = "nomad-clients"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["4646-4647"]
  }

  source_tags   = ["consul-cluster"]
  target_tags   = ["nomad-clients"]
}

resource "google_compute_firewall" "nomad-apps" {
  name    = "nomad-apps"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["20000-60000", "80", "443"]
  }

  allow {
    protocol = "udp"
    ports    = ["20000-60000"]
  }

  source_tags   = ["traefik", "nomad-clients", "consul-cluster"]
  target_tags   = ["nomad-clients"]
}
