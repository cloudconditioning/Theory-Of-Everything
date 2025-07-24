variable "resoure_group_name" {
  type        = string
  description = "Name of the resource group holding enterprise resources"
}

variable "environment_suffix" {
  type = "enterprise"
}
variable "nsg_prefix" {
  type    = string
  default = "nsg"
}

variable "vnet_prefix" {
  type    = string
  default = "vnet"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "dns_servers_addresses" {
  type    = list(string)
  default = ["10.0.1.1", "10.0.1.2"]
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
    security_group   = optional(string)
  }))

  default = {
    "domain-controllers" = {
      address_prefixes = ["10.0.1.0/24"]
    },
    "infra-services" = {
      address_prefixes = ["10.0.2.0/24"]
    },
    "virtualization" = {
      address_prefixes = ["10.0.3.0/24"]
    },
    "file-servers" = {
      address_prefixes = ["10.0.4.0/24"]
    },
    "database" = {
      address_prefixes = ["10.0.5.0/24"]
    },
    "exchange" = {
      address_prefixes = ["10.0.6.0/24"]
    },
    "sharepoint" = {
      address_prefixes = ["10.0.7.0/24"]
    },
    "management" = {
      address_prefixes = ["10.0.8.0/24"]
    },
    "security" = {
      address_prefixes = ["10.0.9.0/24"]
    },
    "endpoints" = {
      address_prefixes = ["10.0.10.0/24"]
    },
    "cloud-gateway" = {
      address_prefixes = ["10.0.11.0/24"]
    },
    "bastion" = {
      address_prefixes = ["10.0.100.0/24"]
    }
  }
}