# Create Custom Role Defintions
## when executing module, use data sources to the the scope ID
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition

resource "azurerm_role_definition" "custom_role" {
  name = var.custom_role_name
  scope = var.scope
  description = var.custom_role_description

    dynamic "permissions" {
        for_each = var.permissions
        content {
            actions = permissions.value.actions
            not_actions = permissions.value.not_actions
        }
    }
  
  
  assignable_scopes = var.assignable_scopes
}