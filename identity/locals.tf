# Issuer and Audeince Variables for GitHub

locals {
  gh_issuer                          = "https://token.actions.githubusercontent.com"
  gh_audience                        = "api://AzureADTokenExchange" # Find Audience - https://waynegoosen.com/post/azure-federated-identity-credentials-terraform-github-actions-guide/
  directory_reader_role              = "Directory Readers"
  storage_blob_data_contributor_role = "Storage Blob Data Contributor"
  gh_role_assignments = {

    "Directory Readers"             = "88d8e3e3-8f55-4a1e-953a-9b9898b8876b"
    "Storage Blob Data Contributor" = "ba92f5b4-2d11-453d-a403-e96b0029c9fe"
  }
  group_creator_role_name   = "Resource Group Creator"
  group_creator_description = "This user will be able to create and read user groups"
}


