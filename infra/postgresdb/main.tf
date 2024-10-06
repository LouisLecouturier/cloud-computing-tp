
resource "random_string" "db_account_name" {
  count = var.postgres_account_name == null ? 1 : 0

  length  = 20
  upper   = false
  special = false
  numeric = false
}


locals {
  postgres_account_name = try(random_string.db_account_name[0].result, var.postgres_account_name)
}

resource "azurerm_postgresql_server" "tp2" {
  name                    = local.postgres_account_name
  location                = var.location
  resource_group_name     = var.azurerm_resource_group_name
  ssl_enforcement_enabled = true
  version                 = "11"
  sku_name                = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

}


resource "azurerm_postgresql_database" "tp2" {
  name                = "tp2-db"
  resource_group_name = var.azurerm_resource_group_name
  server_name         = azurerm_postgresql_server.tp2.name
  charset             = "UTF8"
  collation           = "English_United States.1252"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
