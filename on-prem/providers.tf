terraform {
    
   backend "azurerm" {
    resource_group_name  = "rg-tfstate-enterprise"
    storage_account_name = "tfstateccj71qzqqm"
    container_name       = "tfstate"
    key                  = "onprem.tfstate"
    
  }
}