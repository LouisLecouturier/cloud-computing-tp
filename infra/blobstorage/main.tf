
resource "azurerm_storage_account" "tp2" {
  name                     = "tp2storacc"
  resource_group_name      = var.azurerm_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_container" "tp2" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.tp2.name
  container_access_type = "private"
}


resource "azurerm_storage_blob" "myblob" {
  name                   = "test.txt"
  storage_account_name   = azurerm_storage_account.tp2.name
  storage_container_name = azurerm_storage_container.tp2.name
  type                   = "Block"
  source                 = "./blobstorage/test.txt"
}
