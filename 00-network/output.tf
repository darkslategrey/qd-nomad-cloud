output "traefik_ip" {
  value = "${google_compute_global_address.traefik.address}"
}
output "bastion_ip" {
  value = "${google_compute_address.bastion.address}"
}
