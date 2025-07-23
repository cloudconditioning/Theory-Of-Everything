# Create the Resource Group to store identities

module "rg-identity" {
  source                  = "./resource-group"
  resource_group_name     = var.identity_resource_group_name
  resource_group_location = var.identity_resource_group_location
}

# Create the GitHub User Assigned Managed Identity
module "gh-uami" {
  source              = "./managed-identity"
  uami_name           = var.uami_name
  resource_group_name = module.rg-identity.name_of_resource_group
  location            = module.rg-identity.location_of_resource_group
}

# Create the Federated Identity Credential: Main and Dev Branches
## Notes on Federated Identity for GitHub: https://mattias.engineer/blog/2024/azure-federated-credentials-github/#federated-identity-credentials
module "gh-federated-identity-branches" {
  for_each                = toset(var.github_branches)
  source                  = "./federated-identity"
  federated_identity_name = "${var.federated_identity_prefix}-${each.value}"
  issuer                  = local.gh_issuer
  parent_id               = module.gh-uami.uami_id
  subject                 = "repo:${var.github_org_name}/${var.github_repo_name}:ref:refs/heads/${each.value}"
  audience                = local.gh_audience
  resource_group_name     = module.rg-identity.name_of_resource_group
}

# Create the Federated Identity Credential: Pull Request
module "gh-federated-identity-branches-pull-request" {
  source                  = "./federated-identity"
  federated_identity_name = "${var.federated_identity_prefix}-pr"
  issuer                  = local.gh_issuer
  parent_id               = module.gh-uami.uami_id
  subject                 = "repo:${var.github_org_name}/${var.github_repo_name}:pull_request"
  audience                = local.gh_audience
  resource_group_name     = module.rg-identity.name_of_resource_group
}

# Assign Roles to the User Assigned Managed Identity: Directory Readers, Resource Group or Subscription Contributor, Storage Blob Data Contributor 
## Obtain scope of the Resource group and Subscription
data "azurerm_resource_group" "identity_rg" {
  name = module.rg-identity.name_of_resource_group
  depends_on = [ module.rg-identity ]
}

## Create Directory Readers Role

resource "azuread_directory_role" "role" {
  display_name = local.directory_reader_role
}

## Assign Directory Readers Role to the User Assigned Managed Identity
module "directory-readers-role-assignment" {
  source              = "./entra-role-assignments"
  display_name        = azuread_directory_role.role.display_name
  role_id             = module.directory-readers-role-assignment.role_template_id
  principal_object_id = module.gh-uami.uami_principal_id
}

## Use Data Source to get the Storage Account ID
### https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account

data "azurerm_storage_account" "backend_storage_account" {
  name                = "tfstateccj71qzqqm" # determine a way to query this dynamically. Can use `tfstate` file but this is not best practice.
  resource_group_name = "rg-tfstate-enterprise"
}

# Obtain Storage Container Using Storage Account Data Source
data "azurerm_storage_container" "backend_storage_container" {
  name               = "tfstate"
  storage_account_id = data.azurerm_storage_account.backend_storage_account.id
}

## Assign Storage Blob Data Contributor Role to the User Assigned Managed Identity
## Limit scope by assining role to the Storage Container
module "storage-blob-data-contributor-role-assignment" {
  source               = "./azure-role-assignments"
  role_definition_name = local.storage_blob_data_contributor_role
  principal_id         = module.gh-uami.uami_principal_id
  scope                = data.azurerm_storage_container.backend_storage_container.id

}

################################################    TEST CODE   ################################################

module "self-storage-blob-data-contributor-role-assignment" {
  source               = "./azure-role-assignments"
  role_definition_name = local.storage_blob_data_contributor_role
  principal_id         = "68b75708-6c25-48c2-9bd9-bc6f7a730c0e"
  scope                = data.azurerm_storage_container.backend_storage_container.id

}