terraform {
  backend "gcs" {
    bucket      = "terraform-state-vatsyk1"
    prefix      = "terraform/state"
    credentials = "/home/yuriivatsyk/gcp-lab-terraform/application_default_credentials.json"
  }
}