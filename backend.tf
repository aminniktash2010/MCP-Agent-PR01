terraform {
  backend "azurerm" {
    resource_group_name  = "rg-mcp-dev"
    storage_account_name = "stmcptfstate"
    container_name      = "tfstate"
    key                = "mcp.tfstate"
  }
}
