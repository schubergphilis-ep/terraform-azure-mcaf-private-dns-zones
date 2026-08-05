# terraform-azure-mcaf-pdns-zones
Terraform Module to create all privatelink dns zones except `privatelink.azure.com` and (by default) any zone from microsoft containing a `{dnsPrefix}` annotation.

> [!IMPORTANT]
> If you do not use private link scope for monitoring, ensure you add the following to `zone_resolution_policies`
>```terraform
>zone_resolution_policies = {
>  "privatelink.monitoring.azure.net" = "NxDomainRedirect"
>}
>```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.36, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.36, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Location used for the resource group and in some Private DNS Zones | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the resources. | `string` | n/a | yes |
| <a name="input_shortlocation"></a> [shortlocation](#input\_shortlocation) | shortcode of the location used in some Private DNS Zones | `string` | n/a | yes |
| <a name="input_additional_zones"></a> [additional\_zones](#input\_additional\_zones) | Additional Private DNS Zones to create | `list(string)` | `[]` | no |
| <a name="input_query_zones"></a> [query\_zones](#input\_query\_zones) | if set to true will query for created zones instead of creating them, used for creating vnet links | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | The ID of the virtual network to link the Private DNS Zones to | `string` | `null` | no |
| <a name="input_zone_resolution_policies"></a> [zone\_resolution\_policies](#input\_zone\_resolution\_policies) | Map of zone names to their resolution policies. Each Zone can have either 'Default' or 'NxDomainRedirect' as a value. If the zone is not specified, 'Default' will be used for all zones | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_dns_zones"></a> [private\_dns\_zones](#output\_private\_dns\_zones) | object with all created Private DNS Zones |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | ID of the Resource Group created by the module |
<!-- END_TF_DOCS -->