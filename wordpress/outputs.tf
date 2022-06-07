# Virtual Network Outputs
## Virtual Network Name
output "virtual_network_name" {
  description = "Virtual Network Name"
  value = azurerm_virtual_network.vnet.name
}
## Virtual Network ID
output "virtual_network_id" {
  description = "Virtual Network ID"
  value = azurerm_virtual_network.vnet.id
}

# Subnet Outputs (We will write for one web subnet and rest all we will ignore for now)
## Subnet Name 
output "web_subnet_name" {
  description = "WebTier Subnet Name"
  value = azurerm_subnet.websubnet.name
}

## Subnet ID 
output "web_subnet_id" {
  description = "WebTier Subnet ID"
  value = azurerm_subnet.websubnet.id
}

# Network Security Outputs
## Web Subnet NSG Name 
output "web_subnet_nsg_name" {
  description = "WebTier Subnet NSG Name"
  value = azurerm_network_security_group.web_subnet_nsg.name
}

## Web Subnet NSG ID 
output "web_subnet_nsg_id" {
  description = "WebTier Subnet NSG ID"
  value = azurerm_network_security_group.web_subnet_nsg.id
}
# Output Values
output "mysql_server_fqdn" {
  description = "MySQL Server FQDN"
  value = azurerm_mysql_server.mysql_server.fqdn
}

# Storage Account Outputs
output "storage_account_primary_access_key" {
  value = azurerm_storage_account.storage_account.primary_access_key
  sensitive = true
}
output "storage_account_primary_web_endpoint" {
  value = azurerm_storage_account.storage_account.primary_web_endpoint
}
output "storage_account_primary_web_host" {
  value = azurerm_storage_account.storage_account.primary_web_host
}
output "storage_account_name" {
   value = azurerm_storage_account.storage_account.name 
}

# VM Scale Set Outputs

#output "web_vmss_id" {
#  description = "Web Virtual Machine Scale Set ID"
#  value = azurerm_linux_virtual_machine_scale_set.web_vmss.id 
#}

# Application Gateway Outputs
output "web_ag_id" {
  description = "Azure Application Gateway ID"  
  value = azurerm_application_gateway.web_ag.id 
}

output "web_ag_public_ip_1" {
  description = "Azure Application Gateway Public IP 1"  
  value = azurerm_public_ip.web_ag_publicip.ip_address
}