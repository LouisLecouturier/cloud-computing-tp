resource "azurerm_resource_group" "tp2" {
  name     = "tp2-rg"
  location = var.resource_group_location
}


module "postgresdb" {
  source                      = "./postgresdb"
  location                    = azurerm_resource_group.tp2.location
  azurerm_resource_group_name = azurerm_resource_group.tp2.name
}


module "blobstorage" {
  source                      = "./blobstorage"
  location                    = azurerm_resource_group.tp2.location
  azurerm_resource_group_name = azurerm_resource_group.tp2.name
}
