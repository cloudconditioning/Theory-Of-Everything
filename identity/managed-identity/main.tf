# Create the managed identities

## User Assigned Managed Identity Creation

### https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity

resource "azurerm_user_assigned_identity" "uami" {
    name = var.uami_name
    resource_group_name = var.resource_group_name
    location = var.location

      lifecycle {
    prevent_destroy = true
  }
}


