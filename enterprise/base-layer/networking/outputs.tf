output "bastion_nsg_name" {
  value = azurerm_network_security_group.bastion_nsg.name
}

# Subnet NSG

output "subnet_nsg" {
  value = azurerm_network_security_group.subnet_nsg.name
}

# Virtual Network
output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}


# Subnets
output "enterprise_subnet_names" {
  value = {
    for subnet_name, subnet in azurerm_subnet.enterprise_subnets :
    subnet_name => subnet.address_prefixes
  }


}


# Bastion NSG Rules
output "bastion_nsg_rules" {
  value = {
    for rule_name, rule in azurerm_network_security_rule.nsg_rules_bastion :
    rule_name => rule.destination_port_range
  }
}

/*
######### Subnet NSG rules - I have not created the NSG rules for the other subnets yet
output "subnet_nsg_rules" {
  value = {
    for rule_name , rule in azurerm_network_security_rule.nsg_rules_subnets:
    rule_name => rule.destination_port_range
  }
}
*/