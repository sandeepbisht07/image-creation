packer {
  required_plugins {
    googlecompute = {
      version = "~> v1.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "ubuntu" {
  image_name          = "packer-ubuntu-gcp-{{timestamp}}"
  image_description   = "Ubuntu 20-04 Image with Ngnix-{{timestamp}}"
  project_id          = "my-project-amit1-415215"
  network_project_id  = "my-project-amit1-415215"
  network             = "projects/my-project-amit1-415215/global/networks/project-my-project-amit1-415215-spoke-vpc"
  subnetwork          = "projects/my-project-amit1-415215/regions/us-central1/subnetworks/project-my-project-amit1-415215-spoke-subnet"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "ubuntu"
  zone                = "us-central1-a"
  use_internal_ip    = true
  omit_external_ip   = true
  tags = ["packer-image", "packer"]
  #wait_to_add_ssh_keys = "20s"
  ssh_agent_auth = true
  #use_iap = true
  #use_os_login = true
  #metadata = {     block-project-ssh-keys = "true"   }
  #impersonate_service_account = "cloud-build@my-project-amit1-415215.iam.gserviceaccount.com"
}

build {
  sources = ["sources.googlecompute.ubuntu"]

  provisioner "ansible" {
    playbook_file = "/workspace/packer-build/ansible/playbooks/playbook.yml"
    extra_arguments = [ "-vvv" ]
    user = "ubuntu"
  }
}