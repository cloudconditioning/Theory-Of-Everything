
variable "identity_resource_group_name" {
  type    = string
  default = "rg-identity"
}

variable "identity_resource_group_location" {
  type    = string
  default = "EastUS2"
}

variable "federated_identity_prefix" {
  type        = string
  description = "Prefix of the Federated Identity Credential"
  default     = "gh-federated-identity"
}

variable "uami_name" {
  type        = string
  description = "Name of the User Assigned Managed Identity"
  default     = "GitHub-Managed-Identity"
}

variable "github_org_name" {
  type        = string
  description = "Name of the GitHub Organization"
  default     = "cloudconditioning"
}

variable "github_repo_name" {
  type        = string
  description = "Name of the GitHub Repository"
  default     = "Theory-Of-Everything"
}

variable "github_branches" {
  type    = list(string) # Consider using a set for  unique branch names
  default = ["main", "dev"]
}

