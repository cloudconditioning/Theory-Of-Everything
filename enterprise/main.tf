resource "azurerm_resource_group" "rg-enterprise" {
  name     = var.resource_group_name
  location = var.location
}