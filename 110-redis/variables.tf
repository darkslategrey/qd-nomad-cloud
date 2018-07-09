 ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "gcp_project" {
  default = "courseur-staging"
}

variable "gcp_zone" {
  default = "europe-west1-b"
}

variable "gcp_region" {
  description = "All GCP resources will be launched in this Region."
  default = "europe-west1"
}

variable "cluster_name" {
  description = "The name of the Consul cluster (e.g. consul-stage). This variable is used to namespace all resources created by this module."
  default = "redis-cluster"
}

variable "cluster_tag_name" {
  description = "The tag name the Compute Instances will look for to automatically discover each other and form a cluster. TIP: If running more than one Consul Server cluster, each cluster should have its own unique tag name."
  default = "consul-cluster"
}

variable "machine_type" {
  description = "The machine type of the Compute Instance to run for each node in the cluster (e.g. n1-standard-1)."
  default = "f1-micro"
}

variable "consul_server_cluster_size" {
  description = "The number of nodes to have in the Consul Server cluster. We strongly recommended that you use either 3 or 5."
  default = 2
}

variable "consul_client_cluster_size" {
  description = "The number of nodes to have in the Consul Client example cluster. Any number of nodes is permissible, though 3 is usually enough to test.."
  default = 2
}

variable "cluster_size" {
  description = "The number of nodes to have in the Consul cluster. We strongly recommended that you use either 3 or 5."
  default = "2"
}

data "google_compute_image" "hashistack" {
  name    = "hashistack-courseur-v11"
}

variable "source_image" {
  description = "The source image used to create the boot disk for a Consul Server node. Only images based on Ubuntu 16.04 LTS are supported at this time."
  default = "hashistack-courseur-v11"
}

variable "labels" {
  type = "map"
  default = {
    node_type = "redis"
  }
}

# variable "persistent_disk" {
#   default = "redis-disk-1"
# }

variable "consul_server_cluster_name" {
  description = "The name of the Consul Server cluster. All resources will be namespaced by this value. E.g. consul-server-prod"
  default = "consul-cluster"
}

variable "consul_client_cluster_name" {
  description = "The name of the Consul Client example cluster. All resources will be namespaced by this value. E.g. consul-client-example"
  default = "redis-cluster"
}

variable "consul_server_cluster_tag_name" {
  description = "The tag the consul server Compute Instances will look for to automatically discover each other and form a cluster. TIP: If running more than one Consul Server cluster, each cluster should have its own unique tag name. If you're not sure what to put for this value, just use the value entered in var.cluster_name."
  default = "consul-cluster"
}

variable "consul_client_cluster_tag_name" {
  description = "A tag that will uniquely identify the Consul Clients. In this example, the Consul Server cluster uses this tag to identify the Consul Client servers that should have query permissions."
  default = "consul-cluster"
}

variable "consul_server_source_image" {
  description = "The Google Image used to launch each node in the Consul Server cluster."
  default = "hashistack-courseur-v11"
  # default = "$${data.google_compute_image.hashistack.self_link}"
}

variable "consul_client_source_image" {
  description = "The Google Image used to launch each node in the Consul Client cluster."
  default = "hashistack-courseur-v11"
  # default = "$"
}


# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "instance_group_target_pools" {
  description = "To use a Load Balancer with the Consul cluster, you must populate this value. Specifically, this is the list of Target Pool URLs to which new Compute Instances in the Instance Group created by this module will be added. Note that updating the Target Pools attribute does not affect existing Compute Instances. Note also that use of a Load Balancer with Consul is generally discouraged; client should instead prefer to talk directly to the server where possible."
  type = "list"
  default = []
}

variable "cluster_description" {
  description = "A description of the Consul cluster; it will be added to the Compute Instance Template."
  default = ""
}

variable "assign_public_ip_addresses" {
  description = "If true, each of the Compute Instances will receive a public IP address and be reachable from the Public Internet (if Firewall rules permit). If false, the Compute Instances will have private IP addresses only. In production, this should be set to false."
  default = true
}

variable "network_name" {
  description = "The name of the VPC Network where all resources should be created."
  default = "nomad"
}

variable "subnetwork_name" {
  description = "The name of the VPC Subnetwork where all resources should be created. Defaults to the default subnetwork for the network and region."
  default = "priv"
}

variable "custom_tags" {
  description = "A list of tags that will be added to the Compute Instance Template in addition to the tags automatically added by this module."
  type = "list"
  default = ["consul-cluster", "redis"]
}

variable "update_strategy" {
  default = "NONE"
}

variable "instance_group_update_strategy" {
  description = "The update strategy to be used by the Instance Group. IMPORTANT! When you update almost any cluster setting, under the hood, this module creates a new Instance Group Template. Once that Instance Group Template is created, the value of this variable determines how the new Template will be rolled out across the Instance Group. Unfortunately, as of August 2017, Google only supports the options 'RESTART' (instantly restart all Compute Instances and launch new ones from the new Template) or 'NONE' (do nothing; updates should be handled manually). Google does offer a rolling updates feature that perfectly meets our needs, but this is in Alpha (https://goo.gl/MC3mfc). Therefore, until this module supports a built-in rolling update strategy, we recommend using `NONE` and using the alpha rolling updates strategy to roll out new Consul versions. As an alpha feature, be sure you are comfortable with the level of risk you are taking on. For additional detail, see https://goo.gl/hGH6dd."
  default = "NONE"
}

variable "allowed_inbound_cidr_blocks_http_api" {
  description = "A list of CIDR-formatted IP address ranges from which the Compute Instances will allow API connections to Consul."
  type = "list"
  default = ["0.0.0.0/0"]
}

variable "allowed_inbound_tags_http_api" {
  description = "A list of tags from which the Compute Instances will allow API connections to Consul."
  type = "list"
  default = []
}

variable "allowed_inbound_cidr_blocks_dns" {
  description = "A list of CIDR-formatted IP address ranges from which the Compute Instances will allow TCP DNS and UDP DNS connections to Consul."
  type = "list"
  default = ["0.0.0.0/0"]
}

variable "allowed_inbound_tags_dns" {
  description = "A list of tags from which the Compute Instances will allow TCP DNS and UDP DNS connections to Consul."
  type = "list"
  default = []
}

# Metadata

variable "metadata_key_name_for_cluster_size" {
  description = "The key name to be used for the custom metadata attribute that represents the size of the Consul cluster."
  default = "cluster-size"
}

variable "custom_metadata" {
  description = "A map of metadata key value pairs to assign to the Compute Instance metadata."
  type = "map"
  default = {}
}

# Firewall Ports

variable "server_rpc_port" {
  description = "The port used by servers to handle incoming requests from other agents."
  default = 8300
}

variable "cli_rpc_port" {
  description = "The port used by all agents to handle RPC from the CLI."
  default = 8400
}

variable "serf_lan_port" {
  description = "The port used to handle gossip in the LAN. Required by all agents."
  default = 8301
}

variable "serf_wan_port" {
  description = "The port used by servers to gossip over the WAN to other servers."
  default = 8302
}

variable "http_api_port" {
  description = "The port used by clients to talk to the HTTP API"
  default = 8500
}

variable "dns_port" {
  description = "The port used to resolve DNS queries."
  default = 8600
}

# Disk Settings

variable "root_volume_disk_size_gb" {
  description = "The size, in GB, of the root disk volume on each Consul node."
  default = 30
}

variable "root_volume_disk_type" {
  description = "The GCE disk type. Can be either pd-ssd, local-ssd, or pd-standard"
  default = "pd-standard"
}

variable "email_account" {
  default = "courseur-staging@courseur-staging.iam.gserviceaccount.com"
}
variable "domain" {
  default = "cloud.courseur.com"
}

