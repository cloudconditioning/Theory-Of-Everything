variable "resource_group_name" {
  type = string
  description = "Name of the Resource Group where the Federated Identity Credetnial is stored"
}

variable "federated_identity_name" {
  type = string
  description = "Name of the Federated Identity Credential"
}

variable "parent_id" {
  type = string
  description = "Parent ID of the Federated Identity Credential, typicall the User Assigned Managed Identity ID"
}

variable "issuer" {
    type = string
    description = "Issuer URL for the Federated Identity Credential"
}

variable "subject" {
  type = string
  description = "Value used to establish a connection b/w GitHub Actions Worfklow and Entra ID"
}

variable "audience" {
    type = string
    description = "Defines the subject claim to be validated by the the cloud provider"
}

