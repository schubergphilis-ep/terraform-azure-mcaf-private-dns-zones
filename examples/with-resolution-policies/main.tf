terraform {
  required_version = ">= 1.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4"
    }
  }
}

provider "azurerm" {
  subscription_id = "00000000-0000-0000-0000-000000000000"
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "example-rsg"
  location = "West Europe"
}

module "private_dns_zones" {
  source = "../.."

  resource_group_name = azurerm_resource_group.this.name
  locations           = [azurerm_resource_group.this.location]
  virtual_network_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet"

  # Additional zones beyond the default set
  additional_zones = [
    "privatelink.a1b2c3d4e5f6.database.windows.net",
    "privatelink.custom-app.example.com"
  ]

  # Configure resolution policies per zone
  # Available options: "NxDomainRedirect", "Default"
  zone_resolution_policies = {
    # Key Vault - allow internet fallback
    "privatelink.vaultcore.azure.net" = "NxDomainRedirect"

    # Custom application - allow internet fallback
    "privatelink.custom-app.example.com" = "NxDomainRedirect"

    # All other zones not explicitly listed will use "Default" policy
  }

  tags = {
    Environment = "example"
    Purpose     = "demonstrate-resolution-policies"
  }
}

# Example output to show the configured zones
output "configured_zones" {
  description = "All private DNS zones that were configured"
  value       = module.private_dns_zones.private_dns_zones
}