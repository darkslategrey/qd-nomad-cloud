resource "google_compute_address" "traefik" {
  name = "traefik"
  region = "${var.region}"
}

resource "google_compute_address" "bastion" {
  name = "bastion"
  region = "${var.region}"
}

