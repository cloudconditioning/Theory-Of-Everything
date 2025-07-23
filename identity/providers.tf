# View Terraform versioning requirements

## https://github.com/hashicorp/terraform/releases


terraform {
  required_version = "~> 1.12.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0" # Specify the version of AzureRM provider for consistency when deploying resources in the future.
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-enterprise"
    storage_account_name = "tfstateccj71qzqqm"
    container_name       = "tfstate"
    key                  = "identity.tfstate"

  }
}


provider "azurerm" {
  features {}
  # Subscription ID is set in the environment variable `ARM_SUBSCRIPTION_ID`
  ## export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
}