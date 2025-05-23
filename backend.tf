terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-demo"
    storage_account_name = "tfstatevnopvsh3"
    container_name       = "tfstate"
    key                 = "terraform.tfstate"
  }
}
