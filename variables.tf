variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "terraform-demo"
}

variable "storage_account_tier" {
  description = "Storage Account Tier"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Storage Account Replication Type"
  type        = string
  default     = "LRS"
}
