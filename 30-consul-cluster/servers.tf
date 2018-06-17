data "template_file" "startup_script_server" {
  template = "${file("${path.module}/start-server.sh")}"

  vars {
    cluster_tag_name = "${var.consul_server_cluster_tag_name}"
    cluster_size     = "${var.consul_server_cluster_size}"
  }
}

module "consul_serveurs" {
  source = "./module/modules/consul-cluster"
  gcp_zone = "${var.gcp_zone}"
  gcp_region = "${var.gcp_region}"
  cluster_name = "${var.consul_server_cluster_name}"
  cluster_description = "Consul Server cluster"
  cluster_size = "${var.consul_server_cluster_size}"
  cluster_tag_name = "${var.consul_server_cluster_tag_name}"
  startup_script = "${data.template_file.startup_script_server.rendered}"

  # Grant API and DNS access to requests originating from the the Consul client cluster we create below.
  allowed_inbound_tags_http_api = ["${var.consul_client_cluster_tag_name}"]
  allowed_inbound_tags_dns = ["${var.consul_client_cluster_tag_name }"]

  # WARNING! These configuration values are suitable for testing, but for production, see https://www.consul.io/docs/guides/performance.html
  # Production recommendations:
  # - machine_type: At least n1-standard-2 (so that Consul can use at least 2 cores); confirm that you have enough RAM
  #                 to contain between 2 - 4 times the working set size.
  # - root_volume_disk_type: pd-ssd or local-ssd (for write-heavy workloads, use SSDs for the best write throughput)
  # - root_volume_disk_size_gb: Consul's data set is persisted, so this depends on the size of your expected data set
  machine_type = "g1-small"
  root_volume_disk_type = "pd-standard"
  root_volume_disk_size_gb = "15"

  # WARNING! By specifying just the "family" name of the Image, Google will automatically use the latest Consul image.
  # In production, you should specify the exact image name to make it clear which image the current Consul servers are
  # deployed with.
  source_image = "${data.google_compute_image.hashistack.self_link}"
  # ${var.consul_server_source_image}"

  # WARNING! This makes the Consul cluster accessible from the public Internet, which is convenient for testing, but
  # NOT for production usage. In production, set this to false.
  assign_public_ip_addresses = true

  # WARNING! This update strategy will delete and re-create the entire Consul cluster when making some changes to this
  # module. Unfortunately, Google and Terraform do not yet support an automatic stable way of performing a rolling update.
  # For now for production usage, set this to "NONE", and manually coordinate your Consul Server upgrades per Consul docs.
  instance_group_update_strategy = "NONE"

  email_account = "${var.email_account}"
  network_name = "${var.network_name}"
  subnetwork_name = "${var.subnetwork_name}"

}
