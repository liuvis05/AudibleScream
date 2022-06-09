resource "azurerm_storage_account" "storage" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = "wordpressstorage1"
  resource_group_name      = azurerm_resource_group.wordpress.name
  allow_blob_public_access = true
  enable_https_traffic_only = true
}

resource "azurerm_storage_container" "container" {
  name                  = "wordpresscontainer"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container" # "blob" "private"
}
