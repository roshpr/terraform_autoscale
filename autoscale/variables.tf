variable "vpc" { default = "vpc-c6e475a0"}


variable "internal_subnets" { default = "subnet-21d5e968,subnet-46c9866b,subnet-5f87c204" }
variable "external_subnets" { default = "subnet-5887c203,subnet-43c9866e,subnet-20d5e969" }
variable "ami" { default = "ami-f4cc1de2" }

variable "vpcvar" {
  type = "map"
  default = {
    vpc_cidr = "10.0.0.0/16"
    public_subnets = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
    private_subnets = "10.0.10.0/24,10.0.11.0/24,10.0.12.0/24"
    availability_zones = "us-east-1d,us-east-1b,us-east-1c"
    home_networks = "116.197.184.0/27,116.197.184.64/27,66.129.239.0/27,66.129.239.64/27"
  }
}


variable "instance_cfg" {
  type = "map"
  default = {
    proxy.type = "t2.micro"

    proxy.mincount = 3

    proxy.maxcount = 3

    proxy.volume.0 = 20

    proxy.datavolume.0 = 20

    proxy.datapath = "/data"
  }
}

variable "ec2_instance_key" {
  default = "cso-dev-key"
}

variable "root_path" {
  default = ""
}