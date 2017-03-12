variable "aws" {
  type = "map"
  default = {
    profile = "east1"
    region = "us-east-1"
  }
}
provider "aws" {
  region = "${var.aws["region"]}"
  profile = "${var.aws["profile"]}"
}
terraform {
    required_version = ">= 0.8.2"
}
module "autoscale" {
  source = "../autoscale"
  root_path = "${path.root}"
}