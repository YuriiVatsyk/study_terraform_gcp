#--------------------------------------------
# My terraform
# My 1st VM on GCP
#---------------------------------------------

provider "google" {
  credentials = file("my-terraform-project-333616-99849d2a3287.json")
  project = "my-terraform-project-333616"
  region = var.region
  zone = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    access_config {
    }
  }
}
