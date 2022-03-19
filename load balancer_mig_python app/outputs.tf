output "group1_region" {
  value = var.group1_region
}

output "group2_region" {
  value = var.group2_region
}

output "load-balancer-ip" {
  value = module.gce-lb-https.external_ip
}
