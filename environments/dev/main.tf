terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    key = "dev.tfstate"  # Separate state file for dev environment
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group for dev environment
resource "azurerm_resource_group" "dev" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# Use our networking module
module "networking" {
  source              = "../../modules/networking"
  resource_group_name = azurerm_resource_group.dev.name
  location            = var.location
  environment         = var.environment
  address_space      = ["10.1.0.0/16"]  # Dev VNet address space
  subnet_prefixes    = ["10.1.1.0/24", "10.1.2.0/24"]
  subnet_names       = ["app-subnet", "db-subnet"]
}
