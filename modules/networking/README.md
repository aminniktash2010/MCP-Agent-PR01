# Networking Module

This module creates a basic networking setup in Azure with the following resources:
- Virtual Network
- Subnets (configurable number)
- Network Security Groups (one per subnet)
- NSG-Subnet Associations

## Usage

```hcl
module "networking" {
  source = "./modules/networking"

  resource_group_name = "my-resource-group"
  location           = "canadacentral"
  environment        = "dev"
  
  address_space    = ["10.0.0.0/16"]
  subnet_prefixes  = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_names     = ["app-subnet", "db-subnet"]
}
```

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| resource_group_name | Name of the resource group | string | - |
| location | Azure region | string | - |
| environment | Environment name | string | - |
| address_space | VNet address space | list(string) | ["10.0.0.0/16"] |
| subnet_prefixes | Subnet address prefixes | list(string) | ["10.0.1.0/24", "10.0.2.0/24"] |
| subnet_names | Subnet names | list(string) | ["app-subnet", "db-subnet"] |

## Outputs

| Name | Description |
|------|-------------|
| vnet_id | The ID of the created virtual network |
| vnet_name | The name of the created virtual network |
| subnet_ids | Map of subnet names to subnet IDs |
| nsg_ids | Map of NSG names to NSG IDs |
