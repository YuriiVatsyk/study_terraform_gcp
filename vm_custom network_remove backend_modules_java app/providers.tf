provider "google" {
  credentials = file(var.access_file)
  project     = var.project_id
  region      = var.region
}