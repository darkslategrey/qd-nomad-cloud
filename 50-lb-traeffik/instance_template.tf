resource "google_compute_instance_template" "http-simple" {
  name        = "traefik-instance"

  tags = ["traefik", "consul-traefik", "consul-cluster"]

  labels = {
    environment = "staging"
  }

  machine_type         = "${var.instance_type}"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  
  // Create a new boot disk from an image
  disk {
    source_image = "${var.image}"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    # network = "${data.google_compute_network.base.name}"
    subnetwork = "${var.subnet}"
    access_config {}
  }

  metadata_startup_script = "${data.template_file.bootstrap.rendered}"

  service_account {
    email  = "courseur-staging@courseur-staging.iam.gserviceaccount.com"
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

data "template_file" "bootstrap" {
  template = "${file("bootstrap.tpl")}"
  vars {
    domain = "${var.domain}"
    cluster_tag_name = "${var.cluster_tag_name}"
  }
}
