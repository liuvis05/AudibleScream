#wordpress admin username and password
variable "database_admin_login" {
  default = "wordpress"
}


resource "azurerm_mysql_server" "wordpress" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "wordpress-mysql-server-new"
  location            = azurerm_resource_group.rg.location
  version             = "8.0"

  administrator_login          = var.database_admin_login
  administrator_login_password = var.database_admin_password

  sku_name                     = "B_Gen5_2"
  storage_mb                   = "5120"
  auto_grow_enabled            = false
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled" 
}

# Create MySql DataBase
resource "azurerm_mysql_database" "wordpress" {
  name                = "wordpress-mysql-db"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.wordpress.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Config MySQL Server Firewall Rule
resource "azurerm_mysql_firewall_rule" "wordpress" {
  name                = "wordpress-mysql-firewall-rule"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.wordpress.name
  start_ip_address    = azurerm_public_ip.web_ag_publicip.ip_address
  end_ip_address      = azurerm_public_ip.web_ag_publicip.ip_address
}

data "azurerm_mysql_server" "wordpress" {
  name                = azurerm_mysql_server.wordpress.name
  resource_group_name = azurerm_resource_group.rg.name
}