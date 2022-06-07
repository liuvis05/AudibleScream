# Define Local Values in Terraform
locals {
  owners = "sap"
  environment = "dev"
  resource_name_prefix = "sap-dev"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 

locals {
  # Generic 
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
  redirect_configuration_name    = "${azurerm_virtual_network.vnet.name}-rdrcfg"


  # App1
  backend_address_pool_name_app1      = "${azurerm_virtual_network.vnet.name}-beap-app1"
  http_setting_name_app1              = "${azurerm_virtual_network.vnet.name}-be-htst-app1"
  probe_name_app1                = "${azurerm_virtual_network.vnet.name}-be-probe-app1"

  # HTTP Listener -  Port 80
  listener_name_http                  = "${azurerm_virtual_network.vnet.name}-lstn-http"
  request_routing_rule_name_http      = "${azurerm_virtual_network.vnet.name}-rqrt-http"
  frontend_port_name_http             = "${azurerm_virtual_network.vnet.name}-feport-http"


  # HTTPS Listener -  Port 443
  listener_name_https                  = "${azurerm_virtual_network.vnet.name}-lstn-https"
  request_routing_rule_name_https      = "${azurerm_virtual_network.vnet.name}-rqrt-https"
  frontend_port_name_https             = "${azurerm_virtual_network.vnet.name}-feport-https"
  ssl_certificate_name                 = "my-cert-1" 
}

# Azure Resource Group Name 
variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "rg-wordpress"  
}


# Azure Resources Location
variable "resource_group_location" {
  description = "Region in which Azure Resources to be created"
  type = string
  default = "centralus"  
}

# Virtual Network, Subnets and Subnet NSG's

## Virtual Network
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet-wordpress"
}

variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/16"]
}


# Web Subnet Name
variable "web_subnet_name" {
  description = "Virtual Network Web Subnet Name"
  type = string
  default = "websubnet"
}
# Web Subnet Address Space
variable "web_subnet_address" {
  description = "Virtual Network Web Subnet Address Spaces"
  type = list(string)
  default = ["10.0.1.0/24"]
}


# App Subnet Name
variable "app_subnet_name" {
  description = "Virtual Network App Subnet Name"
  type = string
  default = "appsubnet"
}
# App Subnet Address Space
variable "app_subnet_address" {
  description = "Virtual Network App Subnet Address Spaces"
  type = list(string)
  default = ["10.0.11.0/24"]
}


# Database Subnet Name
variable "db_subnet_name" {
  description = "Virtual Network Database Subnet Name"
  type = string
  default = "dbsubnet"
}
# Database Subnet Address Space
variable "db_subnet_address" {
  description = "Virtual Network Database Subnet Address Spaces"
  type = list(string)
  default = ["10.0.21.0/24"]
}


# Bastion / Management Subnet Name
variable "bastion_subnet_name" {
  description = "Virtual Network Bastion Subnet Name"
  type = string
  default = "bastionsubnet"
}
# Bastion / Management Subnet Address Space
variable "bastion_subnet_address" {
  description = "Virtual Network Bastion Subnet Address Spaces"
  type = list(string)
  default = ["10.0.100.0/24"]
}



# Application Gateway Subnet Name
variable "ag_subnet_name" {
  description = "Virtual Network Application Gateway Subnet Name"
  type = string
  default = "agsubnet"
}
# Application Gateway Subnet Address Space
variable "ag_subnet_address" {
  description = "Virtual Network Application Gateway Subnet Address Spaces"
  type = list(string)
  default = ["10.0.51.0/24"]
}
# Linux VM Input Variables Placeholder file.
variable "web_vmss_nsg_inbound_ports" {
  description = "Web VMSS NSG Inbound Ports"
  type = list(string)
  default = [22, 80, 443, 8080]
}

# Input Variables
# DB Name
variable "mysql_db_name" {
  description = "Azure MySQL Database Name"
  type        = string
  default     = "db-wordpress"
}

# DB Username - Enable Sensitive flag
variable "mysql_db_username" {
  description = "Azure MySQL Database Administrator Username"
  type        = string
  default     = "adminwordpress"
}
# DB password - Enable Sensitive flag
variable "mysql_db_password" {
  description = "Azure MySQL Database Administrator Username"
  type        = string

}

# DB Schema Name
variable "mysql_db_schema" {
  description = "Azure MySQL Database Schema Name"
  type        = string
  default     = "wordpress"
}

variable "my_public_ip" {
  description = "What is your public ip?"
  type        = string
}

# Input variable definitions
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "wordpress"
}
variable "storage_account_tier" {
  description = "Storage Account Tier"
  type        = string
  default     = "Standard"
}
variable "storage_account_replication_type" {
  description = "Storage Account Replication Type"
  type        = string
  default     = "LRS"
}
variable "storage_account_kind" {
  description = "Storage Account Kind"
  type        = string
  default     = "StorageV2"
}
variable "static_website_error_404_document" {
  description = "static website error 404 document"
  type        = string
  default     = "error.html"
}