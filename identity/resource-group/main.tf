# Create a resource Group to store identities

## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "rg-identity" {
  name = var.resource_group_name
  location = var.resource_group_location
}