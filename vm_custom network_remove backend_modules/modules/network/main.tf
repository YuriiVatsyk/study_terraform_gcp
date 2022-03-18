resource "google_compute_subnetwork" "subnetwork" {
  name          = var.vpc_subnetwork_name_module
  ip_cidr_range = var.ip_cidr_range_module
  region        = var.region_module
  network       = google_compute_network.vpc.id
}

resource "google_compute_network" "vpc" {
  name                    = var.petclinic_vpc_name_module
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "ssh" {
  project = var.project_id_module
  name    = var.firewall_rule_ssh_module
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "http" {
  project = var.project_id_module
  name    = var.firewall_rule_http_module
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}