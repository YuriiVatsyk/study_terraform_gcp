data "template_file" "group1-startup-script" {
  template = file(format("%s/startup_script2.sh.tpl", path.module))

  vars = {
    PROXY_PATH = "/group1"
  }
}

data "google_compute_instance_template" "bookshelf" {
  name    = "bookshelf-test-template-1"
  project = var.project_id
}

module "mig1" {
  source            = "terraform-google-modules/vm/google//modules/mig"
  version           = "6.2.0"
  instance_template = data.google_compute_instance_template.bookshelf.self_link
  # instance_template = module.mig1_template.self_link
  region      = var.group1_region
  hostname    = "${var.network_name}-group1"
  target_size = 2
  named_ports = [{
    name = "http",
    port = 8080
  }]
  network    = google_compute_network.default.self_link
  subnetwork = google_compute_subnetwork.group1.self_link
}

module "mig2" {
  source            = "terraform-google-modules/vm/google//modules/mig"
  version           = "6.2.0"
  instance_template = data.google_compute_instance_template.bookshelf.self_link
  # instance_template = module.mig2_template.self_link
  region            = var.group2_region
  hostname          = "${var.network_name}-group2"
  target_size       = 2
  named_ports = [{
    name = "http",
    port = 8080
  }]
  network    = google_compute_network.default.self_link
  subnetwork = google_compute_subnetwork.group2.self_link
}
