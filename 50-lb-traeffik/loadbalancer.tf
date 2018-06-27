# resource "google_compute_address" "default" {
#   name = "default"
#   # region = "${var.region}"
# }

resource "google_compute_global_forwarding_rule" "default" {
  name       = "http"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  port_range = "80-80"
  # ip_address = "${google_compute_address.default.self_link}"
  ip_address = "${data.terraform_remote_state.traefik_ip.traefik_ip}"
  # region     = "${var.region}"
}

resource "google_compute_target_http_proxy" "default" {
  name        = "traefik-proxy"
  url_map     = "${google_compute_url_map.default.self_link}"
}

resource "google_compute_url_map" "default" {
  name            = "traefik-map"
  default_service = "${google_compute_backend_service.default.self_link}"
}

resource "google_compute_backend_service" "default" {
  name        = "treafik-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 30
  enable_cdn  = false

  backend {
    group = "${element(google_compute_region_instance_group_manager.traefik-cluster.*.instance_group, 0)}"
    balancing_mode = "RATE"
    capacity_scaler = 1.0
    max_rate_per_instance = 10
  }

  # backend {
  #   group = "${element(google_compute_region_instance_group_manager.traefik-https.*.instance_group, 1)}"
  #   balancing_mode = "RATE"
  #   capacity_scaler = 1.0
  #   max_rate_per_instance = 10
  # }

  # backend {
  #   group = "${element(google_compute_region_instance_group_manager.http-simple.*.instance_group, 2)}"
  #   balancing_mode = "RATE"
  #   capacity_scaler = 1.0
  #   max_rate_per_instance = 10
  # }

  health_checks = ["${google_compute_health_check.autohealing.self_link}"]
}
