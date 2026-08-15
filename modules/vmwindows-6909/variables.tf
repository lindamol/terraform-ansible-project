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

variable "subnet_id" {
  description = "Subnet ID for Windows VM"
  type        = string
}

variable "admin_username" {
  description = "Admin username for Windows VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for Windows VM"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Windows VM size"
  type        = string
}

variable "windows_vm_count" {
  description = "Number of Windows VMs"
  type        = number
}

variable "availability_set_name" {
  description = "Name of the Windows availability set"
  type        = string
}

variable "platform_fault_domain_count" {
  description = "Number of fault domains for the Windows availability set"
  type        = number
}

variable "platform_update_domain_count" {
  description = "Number of update domains for the Windows availability set"
  type        = number
}

variable "public_ip_allocation_method" {
  description = "Allocation method for Windows VM public IP addresses"
  type        = string
}

variable "public_ip_sku" {
  description = "SKU for Windows VM public IP addresses"
  type        = string
}

variable "private_ip_address_allocation" {
  description = "Private IP address allocation method for Windows VM NICs"
  type        = string
}

variable "dns_label_prefix" {
  description = "DNS label prefix for Windows VM public IP addresses"
  type        = string
}

variable "computer_name_prefix" {
  description = "Computer name prefix for Windows VMs"
  type        = string
}

variable "os_disk_caching" {
  description = "Caching mode for Windows VM operating system disks"
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for Windows VM operating system disks"
  type        = string
}

variable "image_publisher" {
  description = "Publisher of the Windows VM image"
  type        = string
}

variable "image_offer" {
  description = "Offer of the Windows VM image"
  type        = string
}

variable "image_sku" {
  description = "SKU of the Windows VM image"
  type        = string
}

variable "image_version" {
  description = "Version of the Windows VM image"
  type        = string
}

variable "boot_diagnostics_storage_uri" {
  description = "Storage account blob endpoint for boot diagnostics"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}