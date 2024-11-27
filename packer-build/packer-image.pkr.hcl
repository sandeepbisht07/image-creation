packer {
  required_plugins {
    googlecompute = {
      version = "~> v1.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "ubuntuvm" {
  image_name          = "packer-ubuntu-gcp-{{timestamp}}"
  image_description   = "Ubuntu 20-04 Image with Ngnix-{{timestamp}}"
  project_id          = "my-project-amit1-415215"
  network_project_id  = "my-project-amit1-415215"
  network             = "projects/my-project-amit1-415215/global/networks/project-my-project-amit1-415215-spoke-vpc"
  subnetwork          = "projects/my-project-amit1-415215/regions/us-central1/subnetworks/project-my-project-amit1-415215-spoke-subnet"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "ubuntu"
  machine_type         = "n1-standard-1"
  zone                = "us-central1-a"
  use_internal_ip    = true
  omit_external_ip   = true
  tags = ["packer-image", "packer"]
  #wait_to_add_ssh_keys = "20s"
  #ssh_agent_auth = true
  ssh_private_key_file = "/workspace/id_rsa"
  metadata = {
    "ssh-keys" = "ubuntu:${file("/workspace/id_rsa.pub")}"
  }
  #impersonate_service_account = "cloud-build@my-project-amit1-415215.iam.gserviceaccount.com"
}

build {
  sources = ["sources.googlecompute.ubuntuvm"]

  provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y nginx"
    ]
    ssh_username = "ubuntu"
    ssh_agent_auth = true
    ssh_private_key_file = "/workspace/id_rsa"
  }
}