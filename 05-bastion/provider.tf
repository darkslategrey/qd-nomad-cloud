provider "google" {
  # credentials = "${file("courseur-staging-faead0157dbd.json")}"
  region = "${var.region_gcp}"
  project = "${var.gcp_project}"
}
