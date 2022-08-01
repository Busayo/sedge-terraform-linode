terraform {
  required_providers {
    linode    = {
    source  = "linode/linode"
    }
  }
}

provider "linode" {
  token         = var.token
  api_version   = "v4beta"
}

resource "linode_instance" "sedge_instance" {
  label     = "sedge_instance_label"
  image     = "linode/ubuntu22.04"
  region    = var.region
  type      = "g6-standard-2"
  root_pass = var.root_pass

  provisioner "file" {
    source = "sedge_setup.sh"
    destination = "/tmp/sedge_setup.sh"
    connection {
      type      = "ssh"
      host      = self.ip_address
      user      = "root"
      password  = var.root_pass
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/sedge_setup.sh",
      "/tmp/sedge_setup.sh",
      "sleep 1"
    ]
    connection {
      type      = "ssh"
      host      = self.ip_address
      user      = "root"
      password  = var.root_pass
    }
  }
}


#variables
variable "token" {}
variable "root_pass" {}
variable "region" {}
