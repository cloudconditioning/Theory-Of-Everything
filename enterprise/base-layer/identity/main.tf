# Create the Virtual Machines for Active Directory Domain Services 
## Domain Controller 1 and 2
## PowerShell Script to Install AD DS and replicate


# Create the Public IP for DC1
resource "azurerm_public_ip" "dc1_public_ip" {
  name                = var.dc1_public_ip_name
  allocation_method   = var.public_ip_allocation_method
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = local.tags
}

# Create the NIC for DC1

resource "azurerm_network_interface" "nic_dc1" {
  name                = var.nic_dc1_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.dc1_ip_name
    subnet_id                     = var.dc1_subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }

  tags = local.tags
}

# Storage account for Boot diagnostics
resource "azurerm_storage_account" "enterprise-sa" {
  name                     = var.storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.storage_account_tier
  account_replication_type = "LRS"
}


# Create the VM For DC1
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

resource "azurerm_windows_virtual_machine" "vm_dc1" {
  name                       = var.vm_dc1_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  size                       = var.dc1_size
  admin_username             = var.dc1_username
  admin_password             = var.dc1_password
  provision_vm_agent         = true # Required to use VM Extensions / PowerShell
  allow_extension_operations = true
  network_interface_ids = [
    azurerm_network_interface.nic_dc1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }

  boot_diagnostics {
    # Configure contributor access for GitHub UAMI first in Identity module
    storage_account_uri = azurerm_storage_account.enterprise-sa.primary_blob_endpoint
  }
}

# VM Extension for DC1 to Install Active Directory
## https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/virtual_machine_extension
## https://silvr.medium.com/bootstrapping-azure-vms-with-powershell-scripts-using-terraform-cab91318dde4
resource "azurerm_virtual_machine_extension" "dc1_adds_install" {
  name                 = var.dc1_vm_extension_name
  virtual_machine_id   = azurerm_windows_virtual_machine.vm_dc1.id
  publisher            = "Microsoft.Compute"     # Validate
  type                 = "CustomScriptExtension" # Validate
  type_handler_version = "1.9"                   # Validate

  settings = <<SETTINGS
  {
  
  
  }
  SETTINGS
}



# Auto shutdown for DC1