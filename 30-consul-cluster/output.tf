output "consul_server_group_manager" {
  value = "${module.consul_clients.instance_group_url}"
}
