module "gce-lb-http" {
  source            = "./module"
  name              = "traefik-http"
  target_tags       = ["${module.mig1.target_tags}"]
  ip_address        = "${data.terraform_remote_state.traefik_ip.traefik_ip}"
  backends          = {
    "0" = [
      { group = "${module.mig1.instance_group}" }
    ],
  }
  backend_params    = [
    # health check path, port name, port number, timeout seconds.
    "/ping,http,80,10"
  ]
}
