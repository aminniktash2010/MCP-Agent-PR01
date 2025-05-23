variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-mcp-prod"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "mcp"
}

variable "tags" {
  description = "Default tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "prod"
    ManagedBy   = "Terraform"
    Project     = "MCP"
  }
}
