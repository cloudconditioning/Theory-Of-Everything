# Enterprise Resource Group Name

output "rg_enterprise_name" {
  value = azurerm_resource_group.rg-enterprise.name
}

# Output the Virtual Networks

output "enterprise_vnet_name" {
  value = module.enterprise_vnet.vnet_name
}

# Output the Subnets
output "subnet_names_prefixes" {
  value = module.enterprise_vnet.enterprise_subnet_names
}

# Output the Bastion NSG name
output "bastion_nsg_name" {
  value = module.enterprise_vnet.bastion_nsg_name
}

# Output the Bastion NSG rules
output "bastion_nsg_rules" {
  value = module.enterprise_vnet.bastion_nsg_rules
}

# Output the Subnet NSG Name
output "subnet_nsg_name" {
  value = module.enterprise_vnet.subnet_nsg
}