resource "google_compute_health_check" "autohealing" {
  name                = "traefik-check"
  check_interval_sec  = 10
  timeout_sec         = 10
  healthy_threshold   = 3
  unhealthy_threshold = 3

  tcp_health_check {
    port         = "80"
  }
}

# Instance group

resource "google_compute_region_instance_group_manager" "traefik-cluster" {
  count = "${length(var.deploy_region)}"
  name = "traefik-cluster"

  base_instance_name = "traefik-instance"
  instance_template  = "${google_compute_instance_template.traefik.self_link}"
  region = "${element(var.deploy_region, count.index)}"

  named_port {
    name = "http"
    port = 443
  }

  auto_healing_policies {
    health_check      = "${google_compute_health_check.autohealing.self_link}"
    initial_delay_sec = 300
  }
}

resource "google_compute_region_autoscaler" "traefik" {
  count = "${length(var.deploy_region)}"
  name   = "traefik-scaler"
  region = "${element(var.deploy_region, count.index)}"
  target = "${element(google_compute_region_instance_group_manager.traefik-cluster.*.self_link, count.index)}"

  autoscaling_policy = {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 60

    load_balancing_utilization {
      target = 0.8
    }
  }
}
