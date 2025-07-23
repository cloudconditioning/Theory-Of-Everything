resource "azuread_directory_role" "role" {
  display_name = var.display_name
}

resource "azuread_directory_role_assignment" "role_assignment" {
    role_id = azuread_directory_role.role.template_id
    principal_object_id = var.principal_object_id
  
}