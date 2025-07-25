# Create Basic Infrastructure for Enterprise Network


# Obtain the data for the resource group

data "azurerm_resource_group" "rg-enterprise" {
  name = var.resource_group_name
}


# Create the Network Security Group


resource "azurerm_network_security_group" "nsg" {
  name                = "${var.nsg_prefix}-${var.environment_suffix}"
  location            = data.azurerm_resource_group.rg-enterprise.location
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name
  
  tags = {
  environment = var.environment_suffix
  managed_by = "terraform"
}

}



# Create the Virtual Network
## Create the subnets inside the vnet

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_prefix}-${var.environment_suffix}"
  location            = data.azurerm_resource_group.rg-enterprise.location
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_servers_addresses

  tags = {
  environment = var.environment_suffix
  managed_by = "terraform"
}

## Below code is for creating subnets inline with virtual network
/*
  dynamic "subnet" {
    for_each = var.subnets
    content {
      name             = subnet.key 
      address_prefixes = subnet.value.address_prefixes
    }
  }*/
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
resource "azurerm_subnet" "enterprise_subnets" {
  depends_on = [ azurerm_virtual_network.vnet ]
  for_each = var.subnets
  name = each.key
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = each.value.address_prefixes

  
}



# Associate the nsg to the subnets
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  depends_on = [ azurerm_network_security_group.nsg ]
  for_each = var.subnets
  subnet_id = azurerm_subnet.enterprise_subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}