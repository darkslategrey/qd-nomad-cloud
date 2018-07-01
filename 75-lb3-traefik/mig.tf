/*
 * Copyright 2017 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable group1_size {
  default = "2"
}

variable group2_size {
  default = "2"
}

data "template_file" "bootstrap" {
  template = "${file("bootstrap.tpl")}"
  vars {
    domain = "${var.domain}"
    cluster_tag_name = "${var.cluster_tag_name}"
  }
}

module "mig1" {
  source            = "./mig_module"
  region            = "europe-west1"
  zone              = "europe-west1-b"
  
  name              = "traefik-group"
  size              = "${var.group1_size}"
  compute_image     = "hashistack-courseur-v6"
  target_tags       = ["traefik", "consul-cluster"]
  service_port      = 80
  service_port_name = "http"
  network           = "${var.network}"
  subnetwork = "${var.subnetwork}"
  startup_script    = "${data.template_file.bootstrap.rendered}"
  machine_type      = "n1-standard-1"
  service_account_email = "${var.service_account_email}"
  automatic_restart = false
}
