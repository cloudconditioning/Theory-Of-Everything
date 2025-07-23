output "federated_identity_credential_name" {
  value = azurerm_federated_identity_credential.federated_identity.name
  description = "Name of the Federated Identity Credential"
}

output "federated_identity_credential_id" {
    value = azurerm_federated_identity_credential.federated_identity.id
    description = "Federatd Identity Credential ID"
}