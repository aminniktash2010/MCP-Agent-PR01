# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

provider "random" {}

# Create a resource group for Terraform state
resource "azurerm_resource_group" "rg" {
  name     = "rg-mcp-tfstate"
  location = "canadacentral"

  tags = {
    Environment = "shared"
    Project     = "MCP"
    ManagedBy   = "Terraform"
  }
}

# Create storage account for Terraform state
resource "azurerm_storage_account" "tfstate" {
  name                     = "stmcptfstate${random_string.storage_account_suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"  # Using GRS for better state file protection
  min_tls_version         = "TLS1_2"

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    Environment = "shared"
    Project     = "MCP"
    ManagedBy   = "Terraform"
  }
}

# Generate random suffix for globally unique storage account name
resource "random_string" "storage_account_suffix" {
  length  = 8
  special = false
  upper   = false
}
