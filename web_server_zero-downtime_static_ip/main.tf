#--------------------------------------------
# My terraform
# My web_server on GCP
#---------------------------------------------

provider "google" {
  credentials = file("my-terraform-project-333616-99849d2a3287.json")
  project = "my-terraform-project-333616"
  region = "us-west1"
  zone = "us-west1-b"
}

  resource "google_compute_address" "static" {
    name = "ipv4-address"
  }

resource "google_compute_firewall" "rules" {
  project     = "my-terraform-project-333616"
  name        = "my-firewall-rule"
  network     = "default"
  description = "Creates firewall rule targeting tagged instances + HTTP"

  allow {
    protocol  = "tcp"
    ports     = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags =        ["http-server"]
}

resource "google_compute_instance" "vm_instance" {
  name         = "webserver"
  machine_type = "f1-micro"
  tags         = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  metadata_startup_script = file("./apache2.sh")

   scheduling {
     preemptible       = true
     automatic_restart = false
   }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  lifecycle {
      create_before_destroy = true
    }
}

output "google_compute_instance_id" {
  value = google_compute_instance.vm_instance.id
}
