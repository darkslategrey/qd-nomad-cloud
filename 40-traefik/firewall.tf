# resource "google_compute_firewall" "http" {
#   name    = "allow-http-https"
#   network = "${data.google_compute_network.base.name}"

#   allow {
#     protocol = "tcp"
#     ports    = ["80", "443"]
#   }

#   target_tags = ["http", "https", "traefik", "traefik-http"]
#   source_ranges = ["130.211.0.0/22", "35.191.0.0/16"] # "0.0.0.0/0"]
# }

# resource "google_compute_firewall" "ssh" {
#   name    = "nomad-ssh"
#   network = "nomad" # "${data.google_compute_network.base.name}"

#   allow {
#     protocol = "tcp"
#     ports    = ["22", "8080"]

#   }

#   target_tags = ["traefik"]
#   source_ranges = ["0.0.0.0/0"]
# }
