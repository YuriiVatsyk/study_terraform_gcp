variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region name"
}

variable "petclinic_vpc_name" {
  description = "petclinic_vpc_name"
}

variable "vpc_subnetwork_name" {
  description = "vpc_subnetwork_name for petclinic"
}

variable "ip_cidr_range" {
  description = "subnet ip range for petclinic"
}

variable "firewall_rule_ssh" {}
variable "firewall_rule_http" {}
variable "access_file" {}
variable "public_ip_static_name" {}
