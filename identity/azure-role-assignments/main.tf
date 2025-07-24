# Assign roles to identities
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment

## Scope - when assiging roles, use the data source to get the ID of the resource group, storage account or what the respective scope is
## Principal ID - ID of the Principal (User, Group, Service Principal or Managed Identity)

resource "azurerm_role_assignment" "role_assignment" {
  scope = var.scope
  role_definition_name = var.role_definition_name
  # role_definition_id = var.role_definition_id  # Use this to assign roles as well
  principal_id = var.principal_id

  lifecycle {
    prevent_destroy = true
  }
  
}

/*
Role assignments include:
- Directory Readers to GH
- Potentially Storage Blob Data Contributor to the UAMI
- If Terraform state file is deploy thru GH CI/CD, the UAMi will need Storage Data Blob Contributor
- what data sources will I need for the role assignments?
*/