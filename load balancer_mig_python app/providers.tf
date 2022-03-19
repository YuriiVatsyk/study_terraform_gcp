provider "google" {
  credentials = file(var.access_file)
  project     = var.project_id
  region      = var.region
}

provider "google-beta" {
  credentials = file(var.access_file)
  project     = var.project_id
  region      = var.region
}