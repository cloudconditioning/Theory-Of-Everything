output "custom_role_definition_id" {
  value = azurerm_role_definition.custom_role.id
}

output "custom_role_scope" {
  value = azurerm_role_definition.custom_role.scope
}

output "custom_role_name" {
  value = azurerm_role_definition.custom_role.name
}