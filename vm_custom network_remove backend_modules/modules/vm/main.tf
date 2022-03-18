resource "google_compute_instance" "vm_instance" {
  name         = "petclinic-app-tf"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  tags         = ["ssh", "web"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.my_image.self_link
    }
  }

  metadata_startup_script = file("./modules/vm/startup_script.sh")

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnetwork_id
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "30344542252-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_address" "static" {
  name = var.public_ip_static
}

data "google_compute_image" "my_image" {
  name = "petclinic-instance-image-v2"
  project = var.project_id_module
}