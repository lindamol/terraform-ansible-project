resource "azurerm_log_analytics_workspace" "law" {
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_analytics_retention_days
  tags                = var.tags
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = var.recovery_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.recovery_vault_sku
  tags                = var.tags
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind

  tags = var.tags
}