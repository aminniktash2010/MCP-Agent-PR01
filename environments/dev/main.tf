terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    # Backend configuration will be provided by workflow
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group for dev environment
resource "azurerm_resource_group" "dev" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Use our networking module
module "networking" {
  source              = "../../modules/networking"
  resource_group_name = azurerm_resource_group.dev.name
  location            = var.location
  environment         = var.environment
  address_space      = ["10.1.0.0/16"]  # Dev VNet address space
  subnet_prefixes    = ["10.1.1.0/24", "10.1.2.0/24"]
  subnet_names       = ["mcp-app-subnet", "mcp-db-subnet"]

  tags = var.tags
}
