resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = var.postgres_server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  version    = var.postgresql_version
  sku_name   = var.postgresql_sku_name
  storage_mb = var.postgresql_storage_mb

  backup_retention_days         = var.postgresql_backup_retention_days
  geo_redundant_backup_enabled  = var.postgresql_geo_redundant_backup_enabled
  public_network_access_enabled = var.postgresql_public_network_access_enabled

  tags = var.tags
}