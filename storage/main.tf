# Terraform Configuration for the Azure Storag Account for Remote Backend
# https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }

  required_version = "~> 1.12.0"

#https://spacelift.io/blog/terraform-migrate-state#example-migrating-local-state-to-azure-storage-account-remote-backend
  backend "azurerm" {
    resource_group_name = "rg-tfstate-enterprise"
    storage_account_name = "tfstateccj71qzqqm"
    container_name = "tfstate"
    key = "storage.tfstate"
  }
}

provider "azurerm" {
  features {}
  # Set the environment variable `ARM_SUBSCRIPTION_ID` to create the storage account in the correct subscription
}

# Create the Resource Group for the Storage Account

resource "azurerm_resource_group" "rg_storage" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    enviornment = "remote-backend"
    created_by  = "Terraform"
    description = "Resource Group for the Azure Storage Account for the Remote Backend"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Create the random string for the Storage Account Name (Must be globally unique)
## https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "sa_string" {
  length  = 8
  special = false
  upper   = false
}


# Create the Azure Storage Account
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

resource "azurerm_storage_account" "backend_storage_account" {
  name                     = "${var.storage_account_name}${random_string.sa_string.result}"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = azurerm_resource_group.rg_storage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  blob_properties {
    versioning_enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}

# Create the Storage Container for the Remote Backend
## Enable versioning - how to do that?

resource "azurerm_storage_container" "container_remote_backend" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.backend_storage_account.id
  container_access_type = "private"

  lifecycle {
    prevent_destroy = true
  }
}

# Get info on current user for the storage account contribution
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "current" {}

# Is this best practice? To call the storage blob data contributor role assignment in the identity module?
resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
  scope                = azurerm_storage_container.container_remote_backend.id
}