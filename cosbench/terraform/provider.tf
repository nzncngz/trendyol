terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}


provider "openstack" {
  user_name   = "cosbench"
  tenant_name = "T1 Tools"
  password    = "C0sbench123"
  auth_url    = "https://hpc.trendyol.com:5000"
  region      = "mars"
  insecure    = "true"
}
