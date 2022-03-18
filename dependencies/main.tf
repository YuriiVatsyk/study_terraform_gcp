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

resource "google_compute_instance" "vm_instance_web" {
  name         = "web-server"
  machine_type = "f1-micro"
  tags         = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

   scheduling {
     preemptible       = true
     automatic_restart = false
   }

  network_interface {
    network = "default"
    access_config {
    }
  }
  depends_on = [google_compute_instance.vm_instance_db, google_compute_instance.vm_instance_app]
}

  resource "google_compute_instance" "vm_instance_app" {
    name         = "app-server"
    machine_type = "f1-micro"
    tags         = ["app"]

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-9"
      }
    }

    scheduling {
      preemptible       = true
      automatic_restart = false
    }

    network_interface {
     network = "default"
     access_config {
     }
    }
    depends_on = [google_compute_instance.vm_instance_db]
}
    resource "google_compute_instance" "vm_instance_db" {
      name         = "data-base"
      machine_type = "f1-micro"
      tags         = ["db"]

      boot_disk {
        initialize_params {
          image = "debian-cloud/debian-9"
        }
      }

      scheduling {
        preemptible       = true
        automatic_restart = false
      }

      network_interface {
       network = "default"
       access_config {
       }
      }
}
