data "terraform_remote_state" "bastion_ip" {
  backend = "local"

  config {
    path = "../00-network/terraform.tfstate"
  }
}
