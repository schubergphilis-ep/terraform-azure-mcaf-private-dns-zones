output "private_dns_zones" {
  description = "object with all created Private DNS Zones"
  value       = var.query_zones ? data.azurerm_private_dns_zone.this : azurerm_private_dns_zone.this
}
