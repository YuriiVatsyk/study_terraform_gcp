output "static_ip" {
  value = module.vm.static_ip_module.address
}

output "cloud_SQL_connection_name" {
  value = google_sql_database_instance.instance.connection_name
}

