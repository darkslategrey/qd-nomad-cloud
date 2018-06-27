resource "google_compute_firewall" "dns" {
  name    = "dns"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["53"]
  }

  allow {
    protocol = "udp"
    ports    = ["53"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "consul-servers" {
  name    = "consul-servers"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["8300-8302", "8500"]
  }

  allow {
    protocol = "udp"
    ports    = ["8301-8302"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["consul-servers", "consul-cluster"]
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

  source_tags   = ["consul-servers", "consul-clients", "consul-traefik", "consul-cluster"]
  target_tags   = ["consul-clients"]
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

  source_tags   = ["consul-servers", "consul-clients", "consul-traefik", "consul-cluster"]
  target_tags   = ["consul-traefik"]
}

resource "google_compute_firewall" "traefik" {
  name    = "traefik"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["traefik"]
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
}
