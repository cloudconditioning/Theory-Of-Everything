output "uami_name" {
  value = azurerm_user_assigned_identity.uami.name
  description = "Name of the User Assigned Managed Identity"
}

output "uami_id" {
  value = azurerm_user_assigned_identity.uami.id
  description = "ID of the Use Assigned Managed Identity"
}

output "uami_principal_id" {
  value = azurerm_user_assigned_identity.uami.principal_id
  description = "Principal ID of the User Assigned Managed Identity"
}