output "log_analytics_name" {
  description = "Name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.law.name
}

output "recovery_vault_name" {
  description = "Name of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.rsv.name
}

output "storage_account_name" {
  description = "Name of the common services storage account"
  value       = azurerm_storage_account.storage.name
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}
