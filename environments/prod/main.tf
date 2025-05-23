terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    key = "mcp-prod.tfstate"  # Separate state file for prod environment
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group for prod environment
resource "azurerm_resource_group" "prod" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Use our networking module
module "networking" {
  source              = "../../modules/networking"
  resource_group_name = azurerm_resource_group.prod.name
  location            = var.location
  environment         = var.environment
  address_space      = ["10.2.0.0/16"]  # Prod VNet address space
  subnet_prefixes    = ["10.2.1.0/24", "10.2.2.0/24"]
  subnet_names       = ["mcp-app-subnet", "mcp-db-subnet"]
  tags               = var.tags
}
