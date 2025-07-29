variable "resource_group_name" {
  description = "Name of resource group for the enterprise deployment"
  type        = string
  default     = "rg-enterprise"
}

variable "location" {
  description = "Location of enterprise resources"
  type        = string
  default     = "East US2"
}
