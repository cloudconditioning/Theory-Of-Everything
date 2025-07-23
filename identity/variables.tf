
variable "identity_resource_group_name" {
  type = string
}

variable "identity_resource_group_location" {
  type = string
}

variable "federated_identity_prefix" {
  type        = string
  description = "Prefix of the Federated Identity Credential"
}

variable "uami_name" {
  type        = string
  description = "Name of the User Assigned Managed Identity"
}

variable "github_org_name" {
  type        = string
  description = "Name of the GitHub Organization"
}

variable "github_repo_name" {
  type        = string
  description = "Name of the GitHub Repository"
}

variable "github_branches" {
  type = list(string) # Consider using a set for  unique branch names
}

