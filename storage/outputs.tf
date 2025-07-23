output "resource_group_name" {
  value       = azurerm_resource_group.rg_storage.name
  description = "Name of the Resource Group for the Storage Account."
}

output "name_of_storage_account" {
  value       = azurerm_storage_account.backend_storage_account.name
  description = "Name of the Azure Storage Account."
}

output "name_of_storage_container" {
  value = azurerm_storage_container.container_remote_backend.name
  description = "Name of the Azure Storage Container for the Remote Backend."
}