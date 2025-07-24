# Create Basic Infrastructure for Enterprise Network


# Obtain the data for the resource group

data "azurerm_resource_group" "rg-enterprise" {
  name = var.resoure_group_name
}


# Create the Network Security Group


resource "azurerm_network_security_group" "nsg" {
  name                = "${var.nsg_prefix}-${var.environment_suffix}"
  location            = data.azurerm_resource_group.rg-enterprise.location
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name
}



# Create the Virtual Network
## Create the subnets inside the vnet

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_prefix}-${var.environment_suffix}"
  location            = data.azurerm_resource_group.rg-enterprise.location
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_servers_addresses

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }
  }
}


# Create the Network Security Rules
## Allow 3389 and SSH from 



