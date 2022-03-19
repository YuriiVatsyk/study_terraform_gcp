module "network" {
  source                     = "./modules/network"
  project_id_module          = var.project_id
  region_module              = var.region
  petclinic_vpc_name_module  = var.petclinic_vpc_name
  vpc_subnetwork_name_module = var.vpc_subnetwork_name
  ip_cidr_range_module       = var.ip_cidr_range
  firewall_rule_ssh_module   = var.firewall_rule_ssh
  firewall_rule_http_module  = var.firewall_rule_http
}

module "vm" {
  source            = "./modules/vm"
  network_id        = module.network.network_resource.id
  subnetwork_id     = module.network.subnetwork_resource.id
  public_ip_static  = var.public_ip_static_name
  project_id_module = var.project_id
}


resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address-petclinic"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.network.network_resource.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = module.network.network_resource.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  name             = "petclinic-db-tf-${random_id.db_name_suffix.hex}"
  region           = var.region
  database_version = "MYSQL_5_7"

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = module.network.network_resource.id
    }
  }
}

resource "google_sql_database" "database" {
  name     = "petclinic_vatsyk"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "users" {
  name     = "petclinic"
  instance = google_sql_database_instance.instance.name
  password = "petclinic"
}