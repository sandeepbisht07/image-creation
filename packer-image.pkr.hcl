packer {
  required_plugins {
    googlecompute = {
      version = "~> v1.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "ubuntu" {
  image_name        = "packer-ubuntu-gcp-{{timestamp}}"
  image_description = "Ubuntu 20-04 Image with Ngnix-{{timestamp}}"
  project_id          = "optical-highway-442406-c0"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "ubuntu"
  tags         = ["packer"]
  zone         = "asia-east1-a"
}

build {
  sources = ["sources.googlecompute.ubuntu"]

  provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y nginx"
    ]
  }
}