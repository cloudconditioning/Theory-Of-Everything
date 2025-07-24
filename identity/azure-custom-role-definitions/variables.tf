variable "custom_role_name" {
  description = "Name of the custom role"
  type = string
}

variable "scope" {
    description = "Scope for the custom role definition (e.g., subscription, resource group)"
    type = string
}

variable "custom_role_description" {
  description = "Description of the custom role"
  type = string
}

variable "permissions" {
  description = "Permissions for the custom role"
  type = list(object({
    actions = list(string)
    not_actions = list(string)
  }))
}

variable "assignable_scopes" {
  description = "Scopes where the custom role can be assigned"
  type = list(string)
}