output "resource_group_id" {
  description = "Resource Group ID"
  value       = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "Storage Account name"
  value       = azurerm_storage_account.tfstate.name
}

output "storage_container_name" {
  description = "Storage Container name"
  value       = azurerm_storage_container.tfstate.name
}

output "storage_account_access_key" {
  description = "Storage Account access key"
  value       = azurerm_storage_account.tfstate.primary_access_key
  sensitive   = true
}
