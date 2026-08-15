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

variable "linux_vm_ids" {
  description = "Linux VM IDs"
  type        = map(string)
}

variable "windows_vm_ids" {
  description = "Windows VM IDs"
  type        = map(string)
}

variable "data_disk_storage_account_type" {
  description = "Storage account type for managed data disks"
  type        = string
}

variable "data_disk_create_option" {
  description = "Create option for managed data disks"
  type        = string
}

variable "data_disk_size_gb" {
  description = "Size of each managed data disk in GB"
  type        = number
}

variable "data_disk_lun" {
  description = "Logical unit number for data disk attachment"
  type        = number
}

variable "data_disk_caching" {
  description = "Caching setting for data disk attachment"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}