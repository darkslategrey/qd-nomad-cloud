resource "google_compute_firewall" "gfs-servers" {
  name    = "gfs-servers"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_tags   = ["gfs-cluster1-server", "consul-cluster"]
  # source_ranges = ["0.0.0.0/0"]
  # target_tags   = ["nomad-servers"]
  target_tags   = ["gfs-cluster1-server", "consul-cluster"]
}
