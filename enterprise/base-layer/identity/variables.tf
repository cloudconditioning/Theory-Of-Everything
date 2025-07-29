variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "nic_dc1_name" {
  type = string
}

variable "dc1_ip_name" {
  type = string
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
  default = "Standard_B2s_v2"
}


variable "dc1_username" {
  type = string
}

variable "dc1_password" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_tier" {
  type = string
}

variable "dc1_vm_extension_name" {
  type = string
}