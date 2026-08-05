data "azurerm_private_dns_zone" "this" {
  for_each            = var.query_zones ? local.private_dns_zones : {}
  name                = each.key
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "this" {
  for_each            = var.query_zones ? {} : local.private_dns_zones
  name                = each.key
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each              = var.virtual_network_id != null ? local.private_dns_zones : {}
  name                  = "${each.key}-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.key].name
  virtual_network_id    = var.virtual_network_id
  resolution_policy     = each.value.resolution_policy

  depends_on = [azurerm_private_dns_zone.this]

  tags = var.tags
}
