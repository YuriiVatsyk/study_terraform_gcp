output "google_compute_instance_id" {
  value = google_compute_instance.vm_instance.id
  description = "This is the instance id"
}

output "address_static" {
  value = google_compute_address.static.address
}
