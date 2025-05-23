terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    key = "prod.tfstate"  # Separate state file for prod environment
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group for prod environment
resource "azurerm_resource_group" "prod" {
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
  resource_group_name = azurerm_resource_group.prod.name
  location            = var.location
  environment         = var.environment
  address_space      = ["10.2.0.0/16"]  # Prod VNet address space
  subnet_prefixes    = ["10.2.1.0/24", "10.2.2.0/24"]
  subnet_names       = ["app-subnet", "db-subnet"]
}
