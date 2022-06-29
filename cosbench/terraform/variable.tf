variable "openstack_release" {
  default = "stein"
}

variable "deployment_name" {
  
  default = "cosbench-enviroment-prepare"
}

variable "region_count" {
  default = 2
}

variable "network" {
  default = "PUBLIC"
}

variable "flavor" {
  default = "7"
}

variable "keypair" {
  default = "infra"
}

variable "instance_image" {
  default = "centos-7"
}

variable "ssh_username" {
  default = "centos"
}

variable "public_key" {
  default = "/Users/barisozen/.ssh/infra.pub"
}

variable "private_key" {
  default = "/Users/barisozen/.ssh/infra"
}

