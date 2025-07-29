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

# Subnet IDs
output "subnet_ids" {
  value = {
    for subnet_name, subnet in azurerm_subnet.enterprise_subnets :
    subnet_name => subnet.id
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

# Output Windows VM Name
output "bastion_vm_name" {
  value = azurerm_windows_virtual_machine.vm_bastion.name
}

# Windows VM Private IP
output "bastion_vm_private_IP" {
  value = azurerm_windows_virtual_machine.vm_bastion.private_ip_address
}

# Windows VM Public IP
output "bastion_vm_public_ip" {
  value = azurerm_windows_virtual_machine.vm_bastion.public_ip_address
}

# Windows VM Admin_Username
output "bastion_vm_username" {
  value = azurerm_windows_virtual_machine.vm_bastion.admin_username
}

# Bastion VM Shutdown ID
output "bastion_shutdown_time" {
  value = azurerm_dev_test_global_vm_shutdown_schedule.bastion_shutdown.daily_recurrence_time
}

# Bastion VM 
output "bastion_shutdown_id" {
  value = azurerm_dev_test_global_vm_shutdown_schedule.bastion_shutdown.id
}





