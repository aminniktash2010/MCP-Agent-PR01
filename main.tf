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
  
  # These will be picked up from environment variables:
  # ARM_CLIENT_ID
  # ARM_CLIENT_SECRET
  # ARM_SUBSCRIPTION_ID
  # ARM_TENANT_ID
}

provider "random" {}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-demo"
  location = "canadacentral"  # Using Canada Central as seen in your existing resources

  tags = {
    Environment = "Development"
    Project     = "Terraform Demo"
  }
}

# Create storage account for Terraform state
resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_string.storage_account_suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version         = "TLS1_2"

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    Environment = "Development"
    Project     = "Terraform Demo"
    Purpose     = "Terraform State"
  }
}

# Generate random suffix for storage account name
resource "random_string" "storage_account_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Create container for Terraform state
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
