terraform {

  required_version = "~> 1.12.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
   backend "azurerm" {
    resource_group_name  = "rg-tfstate-enterprise"
    storage_account_name = "tfstateccj71qzqqm"
    container_name       = "tfstate"
    key                  = "onprem.tfstate"
    
  }
  
 
}

 provider "azurerm" {
    features{}
    # Set Subscription ID using the environment variable `ARM_SUBSCRIPTION_ID`
  }