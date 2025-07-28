# Create the Virtual Machines for Active Directory Domain Services 
## Domain Controller 1 and 2
## PowerShell Script to Install AD DS and replicate


# Create the Public IP for DC1
resource "azurerm_public_ip" "dc1_public_ip" {
  name = var.dc1_public_ip_name
  allocation_method = var.public_ip_allocation_method
  resource_group_name = var.resource_group_name
  location = var.location

  tags = local.tags
}

# Create the NIC for DC1

resource "azurerm_network_interface" "nic_dc1" {
  name = var.nic_dc1_name
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = var.dc1_ip_name
    subnet_id = var.dc1_subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }

  tags = local.tags
}

# Create the VM For DC1
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

resource "azurerm_windows_virtual_machine" "vm_dc1" {
  name = var.vm_dc1_name
  resource_group_name = var.resource_group_name
  location =  var.location
  size = var.dc1_size
  admin_username = var.dc1_username
  admin_password = var.dc1_password
  network_interface_ids = [ 
    azurerm_network_interface.nic_dc1.id 
    ]

  os_disk  {
   caching = "ReadWrite"
   storage_account_type = "Standard_LRS"
 }

   source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }


}



# VM Extension for DC1 to Install Active Directory




# Auto shutdown for DC1