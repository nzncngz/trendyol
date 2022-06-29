resource "openstack_compute_secgroup_v2" "security_group" {
  name        = var.deployment_name
  description = "${var.deployment_name} security group"

  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "udp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_servergroup_v2" "server_group" {
  name     = var.deployment_name
  policies = ["anti-affinity"]
}

resource "openstack_compute_instance_v2" "cosbench_server" {
  name            = "cosbench-${count.index + 1}"
  image_name      = var.instance_image
  flavor_id       = var.flavor
  key_pair        = var.keypair
  security_groups = ["${openstack_compute_secgroup_v2.security_group.name}"]
  count           = 3

  network {
    name = var.network
  }  
  
}

resource "openstack_compute_instance_v2" "ansible_server" {
  name            = "ansible-server-${count.index + 1}"
  image_name      = var.instance_image
  flavor_id       = var.flavor
  key_pair        = var.keypair
  security_groups = ["${openstack_compute_secgroup_v2.security_group.name}"]
  count           = 1
  network {
    name = var.network
  }
   
  provisioner "file" {
    source      = "/Users/barisozen/.ssh/infra"
    destination = "/home/${var.ssh_username}/.ssh/id_rsa"
    connection {
      type        = "ssh"
      user        = var.ssh_username
      private_key = file(var.private_key)
      host        = self.access_ip_v4
    } 
  }  
  provisioner "remote-exec" {
  
   connection {
      type        = "ssh"
      user        = var.ssh_username
      private_key = file(var.private_key)
      host        = self.access_ip_v4
    }  

   inline = [      
      "sudo chmod 0400 /home/${var.ssh_username}/.ssh/id_rsa",
      "sudo yum -y install wget; sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm;  sudo yum -y install epel-release-latest-7.noarch.rpm; sudo yum -y install git ansible git nano; git clone https://github.com/barisozen/trendyol.git"
      
    ]    

  }

}
