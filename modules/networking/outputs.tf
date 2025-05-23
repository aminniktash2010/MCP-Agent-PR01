output "vnet_id" {
  description = "ID of the created Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Name of the created Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = azurerm_subnet.subnet[*].id
}

output "nsg_ids" {
  description = "IDs of the created Network Security Groups"
  value       = azurerm_network_security_group.nsg[*].id
}

output "subnet_names" {
  description = "Names of the created subnets"
  value       = azurerm_subnet.subnet[*].name
}
