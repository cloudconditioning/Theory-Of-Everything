output "name_of_resource_group" {
  value = azurerm_resource_group.rg-identity.name
  description = "Name of the Resource Group where identiites are stored."
}

output "location_of_resource_group" {
    value = azurerm_resource_group.rg-identity.location
    description = "Location of the Resource Group where identities are stored"
}