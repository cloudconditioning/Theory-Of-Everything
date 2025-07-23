variable "scope" {
  type = string
  description = "Level of access granted to the principal"
}

variable "role_definition_name" {
  type = string
  description = "Name of the Role"
}

variable "principal_id" {
  type = string
  description = "ID of the Principal"
}