variable "uami_name" {
  type = string
  description = "Name of the User Assigned Managed Identity"
}

variable "resource_group_name" {
  type = string
  description = "Name of the Resource Group that contains the User Assigned Managed Identity"
}

variable "location" {
  type = string
  description = "Location of the User Assigned Managed Identity"
}