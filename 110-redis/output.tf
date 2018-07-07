# TODO: use this to terraform an external LB

output "instance_group_manager" {
  # value = "${module.consul_clients.cluster_name}"
  value = "${module.consul_clients.instance_group_url}"
  # google_compute_region_instance_group_manager.consul_server.self_link}"
  # value = "${google_compute_region_instance_group_manager.consul_server.instance_group}"
  # : {instance_group_name": {
  # value = "${google_compute_global_address.traefik.address}"
}
# output "bastion_ip" {
#   value = "${google_compute_address.bastion.address}"
# }


# output "redis_disk" {
#   value = "${google_compute_disk.redis_disk.self_link}"
# }
