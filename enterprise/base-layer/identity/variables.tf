variable "resource_group_name" {
  type    = string
  default = "rg-enterprise"
}

variable "location" {
  type    = string
  default = "EastUS2"
}

variable "nic_dc1_name" {
  type    = string
  default = "nic-dc1"

}

variable "dc1_private_ip_name" {
  type    = string
  default = "private-ip-dc1"
}

variable "dc1_subnet_id" {
  type = string
}

variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}

variable "public_ip_allocation_method" {
  type    = string
  default = "Static"
}

variable "dc1_public_ip_name" {
  type    = string
  default = "public-ip-dc1"
}

variable "vm_dc1_name" {
  type    = string
  default = "DC1"
}

# VM Sizes - https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/overview?tabs=breakdownseries%2Cgeneralsizelist%2Ccomputesizelist%2Cmemorysizelist%2Cstoragesizelist%2Cgpusizelist%2Cfpgasizelist%2Chpcsizelist
variable "dc1_size" {
  type    = string
  default = "Standard_B1ms"
}


variable "dc1_username" {
  type    = string
  default = "ccuser"
}

variable "dc1_password" {
  type    = string
  default = "PrimeTime2025"
}

variable "storage_account_name" {
  type    = string
  default = "conditionedcloudent"
}
variable "storage_container_name" {
  type    = string
  default = "scripts"
}

variable "storage_account_tier" {
  type    = string
  default = "Standard"
}

variable "dc1_vm_extension_name" {
  type    = string
  default = "vm-extension-dc1"
}

variable "scripts_container" {
  type    = string
  default = "scripts"
}


variable "adds_script_name" {
  type    = string
  default = "InstallADDS_DC1.ps1"
}