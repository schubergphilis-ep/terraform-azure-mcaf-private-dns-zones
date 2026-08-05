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

  # some sql database types need a dedicated DNS zone, supply them in a seperate list, i.e.
  additional_zones = ["privatelink.a1b2c3d4e5f6.database.windows.net"]
}

