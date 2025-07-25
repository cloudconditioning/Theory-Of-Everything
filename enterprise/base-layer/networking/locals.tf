locals {
  nsg_rules = {
    Allow-RDP = {
    name = "Allow-RDP"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "3389"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    resource_group_name = "rg-vnet"
    network_security_group_name = "nsg1"
    },
    
    Allow-SSH = {
    name = "Allow-RDP"
    priority = 110
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    resource_group_name = "rg-vnet"
    network_security_group_name = "nsg1" 
    }
    }
    
  } 
