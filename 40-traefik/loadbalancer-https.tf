# resource "google_compute_global_forwarding_rule" "https" {
#   name       = "https"
#   target     = "${google_compute_target_https_proxy.default.self_link}"
#   port_range = "443-443"
#   ip_address = "${google_compute_global_address.default.self_link}"
# }

# resource "google_compute_target_https_proxy" "default" {
#   name        = "courseur-https-proxy"
#   url_map     = "${google_compute_url_map.https.self_link}"
# }

# resource "google_compute_url_map" "https" {
#   name            = "courseur-https-map"
#   default_service = "${google_compute_backend_service.https.self_link}"
# }

# resource "google_compute_backend_service" "https" {
#   name        = "courseur-https-back"
#   port_name   = "https"
#   protocol    = "HTTPS"
#   timeout_sec = 30
#   enable_cdn  = false

#   backend {
#     group = "${element(google_compute_region_instance_group_manager.https.*.instance_group, 0)}"
#     balancing_mode = "RATE"
#     capacity_scaler = 1.0
#     max_rate_per_instance = 10
#   }
#   health_checks = ["${google_compute_health_check.autohealing.self_link}"]
# }
