# Remote backend for Powershell script uplaod


# Create the Virtual Machines for Active Directory Domain Services 

## Domain Controller 1 and 2
## PowerShell Script to Install AD DS and replicate


# Create the NIC for DC1

resource "azurerm_network_interface" "nic_dc1" {
  name                = var.nic_dc1_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.dc1_private_ip_name
    subnet_id                     = var.dc1_subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
  }

  tags = local.tags
}




# Storage account for Scripts
resource "azurerm_storage_account" "enterprise-sa" {
  name                          = var.storage_account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  account_tier                  = var.storage_account_tier
  account_replication_type      = "LRS"
  public_network_access_enabled = true

}

# Create the storage container for scripting
resource "azurerm_storage_container" "scripts_container" {
  name                  = var.scripts_container
  storage_account_id    = azurerm_storage_account.enterprise-sa.id
  container_access_type = "blob"
}

# Upload File to Azure Storage
# Upload Install ADDS PowerShell Script to Storage
resource "azurerm_storage_blob" "adds_script" {
  name                   = var.adds_script_name
  storage_account_name   = azurerm_storage_account.enterprise-sa.name
  storage_container_name = azurerm_storage_container.scripts_container.name
  type                   = "Block"
  source                 = "${path.module}/scripts/InstallADDS_DC1.ps1"
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
    storage_account_uri = azurerm_storage_account.enterprise-sa.primary_blob_endpoint
  }
  depends_on = [azurerm_storage_account.enterprise-sa]

}

# VM Extension for DC1 to Install Active Directory
## https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/virtual_machine_extension
## https://silvr.medium.com/bootstrapping-azure-vms-with-powershell-scripts-using-terraform-cab91318dde4
resource "azurerm_virtual_machine_extension" "dc1_adds_install" {
  name                 = var.dc1_vm_extension_name
  virtual_machine_id   = azurerm_windows_virtual_machine.vm_dc1.id
  publisher            = "Microsoft.Compute"     # Validate
  type                 = "CustomScriptExtension" # Validate
  type_handler_version = "2.0"                   # Validate

  settings = jsonencode({
    "fileUris" = [
      "https://conditionedcloudent.blob.core.windows.net/scripts/InstallADDS_DC1.ps1"
    ],

    "commandToExecute" = "powershell.exe -ExecutionPolicy Unrestricted -File InstallADDS_DC1.ps1"
  })
  depends_on = [azurerm_storage_blob.adds_script]
}



# Auto shutdown for DC1