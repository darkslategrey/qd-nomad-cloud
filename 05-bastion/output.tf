# output "gcp_network" {
#   value = "${google_compute_network.nomad.name}"
# }

# output "gcp_priv_subnet" {
#   value = "${google_compute_subnetwork.priv.name}"
# }

# output "gcp_bastion_ip" {
#   value = [
#       "${google_compute_instance.bastion-staging.network_interface.0.access_config.0.assigned_nat_ip}",
#       "${google_compute_instance.bastion-staging.network_interface.0.address}"
#   ]
# }
