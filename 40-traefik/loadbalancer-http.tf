resource "google_compute_global_address" "default" {
  name = "courseur-gloabl-addr"
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "http"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  port_range = "80-80"
  ip_address = "${google_compute_global_address.default.self_link}"
}

resource "google_compute_target_http_proxy" "default" {
  name        = "courseur-http-proxy"
  url_map     = "${google_compute_url_map.http.self_link}"
}

resource "google_compute_url_map" "http" {
  name            = "courseur-http-map"
  default_service = "${google_compute_backend_service.http.self_link}"
}

resource "google_compute_backend_service" "http" {
  name        = "courseur-http-back"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 30
  enable_cdn  = false

  backend {
    group = "${element(google_compute_region_instance_group_manager.traefik-http.*.instance_group, 0)}"
    balancing_mode = "RATE"
    capacity_scaler = 1.0
    max_rate_per_instance = 10
  }
  health_checks = ["${google_compute_health_check.autohealing.self_link}"]
}
