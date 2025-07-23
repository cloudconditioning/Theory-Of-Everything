variable "display_name" {
  type = string
  description = "Display name of the Entra ID role to be assigned"
}

variable "role_id" {
  type = string
  description = "Principal Object ID of the assigned role"
}

variable "principal_object_id" {
    type = string
    description = "Object ID of the principal to whom the role is assigned"
}