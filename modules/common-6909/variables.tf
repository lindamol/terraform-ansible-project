variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "log_analytics_name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "log_analytics_sku" {
  description = "SKU for the Log Analytics Workspace"
  type        = string
}

variable "log_analytics_retention_days" {
  description = "Log Analytics Workspace retention period in days"
  type        = number
}

variable "recovery_vault_name" {
  description = "Name of the Recovery Services Vault"
  type        = string
}

variable "recovery_vault_sku" {
  description = "SKU for the Recovery Services Vault"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account for boot diagnostics"
  type        = string
}

variable "storage_account_tier" {
  description = "Performance tier for the storage account"
  type        = string
}

variable "storage_account_replication_type" {
  description = "Replication type for the storage account"
  type        = string
}

variable "storage_account_kind" {
  description = "Kind of the storage account"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}