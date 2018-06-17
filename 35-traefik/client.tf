module "consul_clients" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "git::git@github.com:gruntwork-io/consul-gcp-module.git//modules/consul-cluster?ref=v0.0.1"
  source = "./module/modules/consul-cluster"

  gcp_zone = "${var.gcp_zone}"
  gcp_region = "${var.gcp_region}"

  cluster_name = "${var.consul_client_cluster_name}"
  cluster_description = "Consul Clients cluster Traefik"
  cluster_size = "${var.consul_client_cluster_size}"
  cluster_tag_name = "${var.consul_client_cluster_tag_name}"
  startup_script = "${data.template_file.startup_script_client.rendered}"

  allowed_inbound_cidr_blocks_http_api = []
  allowed_inbound_tags_http_api = []

  allowed_inbound_cidr_blocks_dns = []
  allowed_inbound_tags_dns = []

  machine_type = "${var.machine_type}"
  root_volume_disk_type = "pd-standard"
  root_volume_disk_size_gb = "15"

  assign_public_ip_addresses = true

  # source_image = "${var.consul_client_source_image}"
  source_image = "${data.google_compute_image.hashistack.self_link}" 
  # Our Consul Clients are completely stateless, so we are free to destroy and re-create them as needed.
  instance_group_update_strategy = "${var.instance_group_update_strategy}"


  network_name = "${var.network_name}"
  subnetwork_name = "${var.subnetwork_name}"
  email_account = "${var.email_account}"
  # create_intracluster_firewall = 0
}

# Render the Startup Script that will run on each Consul Server Instance on boot.
# This script will configure and start Consul.
data "template_file" "startup_script_client" {
  template = "${file("${path.module}/start-client.sh")}"

  vars {
    cluster_tag_name = "${var.cluster_tag_name}"
    domain = "${var.domain}"
  }
}
