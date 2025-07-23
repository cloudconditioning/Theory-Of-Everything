# Resource Group for Identities

output "name_of_resource_group" {
  value       = module.rg-identity.name_of_resource_group
  description = "Name of the Resource Group for Storing Identities"
}

# Locatiion of Resource Group for Identities
output "location_of_resource_group" {
  value       = module.rg-identity.location_of_resource_group
  description = "Location of the Resource Group for Storing Identities"

}

# User Assigned Managed Identity Output
output "User_Assigned_Identity_ID" {
  value       = module.gh-uami.uami_id
  description = "Value of the User Assigned Managed Identity ID for GitHub"
}

# User Assigned Managed Identity Name
output "User_Assigned_Identity_Name" {
  value       = module.gh-uami.uami_name
  description = "User Assigned Managed Identity Name for GitHub"
}

output "User_Assigned_Identity_Principal_ID" {
  value       = module.gh-uami.uami_principal_id
  description = "Principal ID of the User Assigned Managed Identity for GitHub"
}

# Federated Identity Output

output "github_federated_identity_credential_ID" {
  # value = module.gh-federated-identity-branches[each.value].federated_identity_credential_id
  # value = module.gh-federated-identity-branches.federated_identity_credential_id
  value       = [for branch in var.github_branches : module.gh-federated-identity-branches[branch].federated_identity_credential_id]
  description = "Federated Identity Credential ID for the Branch"
}

# Federated Identity Name

output "Federated_Identity_Credential_Name" {
  # value = module.gh-federated-identity-branches[each.value].federated_identity_credential_name
  # value = module.gh-federated-identity-branches.federated_identity_credential_name
  value       = [for branch in var.github_branches : module.gh-federated-identity-branches[branch].federated_identity_credential_name]
  description = "Federated Identity Credential Name"
}

/*
# Role Assignment Output
output "Role_Assignment_ID" {
  value = azurerm_role_assignment.role_assignment.id
  description = "Role Assignment ID for the Principal "
}
*/

output "Resource_Group_Scope" {
  value       = data.azurerm_resource_group.identity_rg.id
  description = "Resource Group Scope for Role Assignment"
}