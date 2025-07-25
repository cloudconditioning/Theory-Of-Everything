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
      name             = subnet.key 
      address_prefixes = subnet.value.address_prefixes
    }
  }
}


# Create the Network Security Rules
## Allow 3389 and SSH

resource "azurerm_network_security_rule" "ns_rule" {
  depends_on = [ azurerm_network_security_group.nsg ]
  for_each = var.nsg_rules_map
  name = each.value.name
  priority = each.value.priority
  direction = each.value.direction
  access = each.value.access
  protocol = each.value.protocol
  source_port_range = each.value.source_port_range
  destination_port_range = each.value.destination_port_range
  source_address_prefix = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  }

# Create subnets

# Associate the nsg to the subnets
