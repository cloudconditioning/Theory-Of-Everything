# Create Basic Infrastructure for Enterprise Network


# Obtain the data for the resource group

data "azurerm_resource_group" "rg-enterprise" {
  name = var.resource_group_name
}


# Create the Network Security Group


resource "azurerm_network_security_group" "bastion_nsg" {
  name                = "${var.nsg_prefix}-${var.environment_suffix}-bastion"
  location            = data.azurerm_resource_group.rg-enterprise.location
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name

  tags = {
    environment = var.environment_suffix
    managed_by  = "terraform"
  }

}



# Create the Virtual Network
## Create the subnets inside the vnet

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_prefix}-${var.environment_suffix}"
  location            = data.azurerm_resource_group.rg-enterprise.location
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name
  address_space       = var.vnet_address_space
  dns_servers         = []

  tags = local.bastion_tags

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

resource "azurerm_network_security_rule" "nsg_rules_bastion" {
  depends_on                  = [azurerm_network_security_group.bastion_nsg]
  for_each                    = var.nsg_rules_bastion
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = data.azurerm_resource_group.rg-enterprise.name
  network_security_group_name = azurerm_network_security_group.bastion_nsg.name


}

resource "azurerm_network_security_group" "subnet_nsg" {
  name                = "${var.nsg_prefix}-${var.environment_suffix}-subnet"
  location            = data.azurerm_resource_group.rg-enterprise.location
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name
  tags = {
    environment = var.environment_suffix
    managed_by  = "terraform"
  }
}

# Create subnets
resource "azurerm_subnet" "enterprise_subnets" {
  depends_on           = [azurerm_virtual_network.vnet]
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.rg-enterprise.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes

}

# Associate the nsg to the bastion subnet
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_association" {
  depends_on = [azurerm_network_security_group.bastion_nsg]
  # for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.enterprise_subnets["bastion"].id
  network_security_group_id = azurerm_network_security_group.bastion_nsg.id

}

# Associate the nsg to the subnets
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  depends_on = [azurerm_network_security_group.subnet_nsg]
  for_each = {
    for key, value in var.subnets :
    key => value if key != "bastion"
  }
  subnet_id                 = azurerm_subnet.enterprise_subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.subnet_nsg.id

}

# Create the Public IP for the Bastion Windows VM
resource "azurerm_public_ip" "public_ip_bastion" {
  name                = var.public_ip_bastion_name
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name
  location            = data.azurerm_resource_group.rg-enterprise.location
  allocation_method   = "Static"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.bastion_tags

}

# Create the azurerm_network_interface for the Bastion Windows VM
resource "azurerm_network_interface" "nic_bastion" {
  name                = var.bastion_nic
  location            = data.azurerm_resource_group.rg-enterprise.location
  resource_group_name = data.azurerm_resource_group.rg-enterprise.name

  ip_configuration {
    name                          = var.bastion_ip # review what this means exactly
    subnet_id                     = azurerm_subnet.enterprise_subnets["bastion"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_bastion.id
  }

  tags = local.bastion_tags
}

# Create the bastion for remote access
## Place in bastion subnet
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

resource "azurerm_windows_virtual_machine" "vm_bastion" {
  name                  = var.vm_bastion_name
  resource_group_name   = data.azurerm_resource_group.rg-enterprise.name
  location              = data.azurerm_resource_group.rg-enterprise.location
  size                  = var.vm_size
  admin_username        = var.admin_username # figure out the way to pass senstive info
  admin_password        = var.admin_password # same as above. This is fine for now becauses this computer will be controlled by AD DS.
  network_interface_ids = [azurerm_network_interface.nic_bastion.id]

  os_disk {
    caching              = var.caching # What does this mean?
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher_bastion
    offer     = var.offer_bastion
    sku       = var.sku_bastion
    version   = var.version_bastion
  }

  tags = local.bastion_tags

}

# Create auto shutdown for Bastion VM
resource "azurerm_dev_test_global_vm_shutdown_schedule" "bastion_shutdown" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm_bastion.id
  location           = data.azurerm_resource_group.rg-enterprise.location
  enabled            = true

  daily_recurrence_time = var.bastion_shutdown_time
  timezone              = local.timezone

  notification_settings {
    enabled         = true
    email           = local.my_email
    time_in_minutes = local.time_in_minutes
  }
}