provider "google" {
  credentials = file("my-terraform-project-333616-99849d2a3287.json")
  project = "my-terraform-project-333616"
  region = "us-west1"
  zone = "us-west1-b"
}

data "google_iam_role" "roleinfo" {
  name = "roles/compute.viewer"
}

data "google_compute_regions" "available" {
}


output "the_role_permissions" {
  value = data.google_iam_role.roleinfo.included_permissions
}

output "google_compute_regions" {
  value = data.google_compute_regions.available.names
}
