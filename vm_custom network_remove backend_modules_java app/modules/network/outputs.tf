output "network_resource" {
  value = google_compute_network.vpc
}

output "subnetwork_resource" {
  value = google_compute_subnetwork.subnetwork
}