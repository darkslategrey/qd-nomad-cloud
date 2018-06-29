data "terraform_remote_state" "traefik_ip" {
  backend = "local"

  config {
    path = "../00-network/terraform.tfstate"
  }
}
