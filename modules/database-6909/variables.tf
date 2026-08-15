variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_prefix" {
  description = "Last 4 digits of Humber ID"
  type        = string
}

variable "postgres_server_name" {
  description = "Name of the PostgreSQL Flexible Server"
  type        = string
}

variable "administrator_login" {
  description = "PostgreSQL admin username"
  type        = string
}

variable "administrator_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}

variable "postgresql_version" {
  description = "PostgreSQL Flexible Server version"
  type        = string
}

variable "postgresql_sku_name" {
  description = "PostgreSQL Flexible Server SKU name"
  type        = string
}

variable "postgresql_storage_mb" {
  description = "PostgreSQL storage size in MB"
  type        = number
}

variable "postgresql_backup_retention_days" {
  description = "PostgreSQL backup retention days"
  type        = number
}

variable "postgresql_geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backup for PostgreSQL Flexible Server"
  type        = bool
}

variable "postgresql_public_network_access_enabled" {
  description = "Enable public network access for PostgreSQL Flexible Server"
  type        = bool
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}