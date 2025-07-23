variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group for the Storage Account for the Remote Backend."
}

variable "location" {
  type        = string
  description = "Location of the Resource Group and Storage Account for the Remote Backend."
}

variable "storage_account_name" {
  type        = string
  description = "Name of the Azure Storage Account for the Remote Backend"
}