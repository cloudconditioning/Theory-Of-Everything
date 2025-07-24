# Federated Identity Creation
## https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential
## https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation-create-trust-user-assigned-managed-identity?pivots=identity-wif-mi-methods-azp
## https://docs.github.com/en/actions/reference/openid-connect-reference

resource "azurerm_federated_identity_credential" "federated_identity" {
    name = var.federated_identity_name
    resource_group_name = var.resource_group_name
    audience = [ var.audience ]
    issuer = var.issuer
    parent_id = var.parent_id
    subject = var.subject

      lifecycle {
    prevent_destroy = true
  }
}