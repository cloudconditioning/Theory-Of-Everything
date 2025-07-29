resource "azurerm_resource_group" "rg-enterprise" {
  name     = var.resource_group_name
  location = var.location
  lifecycle {
    prevent_destroy = true
  }
}


module "enterprise_vnet" {
  depends_on = [azurerm_resource_group.rg-enterprise]
  source     = "./base-layer/networking"

}

module "active_directory" {
  source        = "./base-layer/identity"
  dc1_subnet_id = module.enterprise_vnet.subnet_ids["domain-controllers"]
}