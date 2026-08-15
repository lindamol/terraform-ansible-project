variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region for project resources"
  type        = string
}

variable "humber_id" {
  description = "Full Humber ID"
  type        = string
}

variable "student_name" {
  description = "Student name used in resource tags"
  type        = string
}

variable "resource_prefix" {
  description = "Last 4 digits of Humber ID used as resource prefix"
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "nsg_name" {
  description = "Network security group name"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
}

variable "nsg_rules" {
  description = "Network security group rules"

  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "log_analytics_name" {
  description = "Log Analytics Workspace name"
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
  description = "Recovery Services Vault name"
  type        = string
}

variable "recovery_vault_sku" {
  description = "SKU for the Recovery Services Vault"
  type        = string
}

variable "common_storage_account_name" {
  description = "Storage account name for common services and VM boot diagnostics"
  type        = string
}

variable "storage_account_tier" {
  description = "Performance tier for the common storage account"
  type        = string
}

variable "storage_account_replication_type" {
  description = "Replication type for the common storage account"
  type        = string
}

variable "storage_account_kind" {
  description = "Kind of the common storage account"
  type        = string
}

variable "admin_username" {
  description = "Admin username for virtual machines"
  type        = string
}

variable "linux_vm_size" {
  description = "Linux VM size"
  type        = string
}

variable "windows_vm_size" {
  description = "Windows VM size"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key for Linux VMs"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key for Linux VM provisioner"
  type        = string
}

variable "linux_vms" {
  description = "Map of Linux VMs to create using for_each"

  type = map(object({
    name      = string
    hostname  = string
    dns_label = string
  }))
}

# Linux VM parameterization

variable "linux_availability_set_name" {
  description = "Name of the Linux availability set"
  type        = string
}

variable "linux_platform_fault_domain_count" {
  description = "Number of fault domains for the Linux availability set"
  type        = number
}

variable "linux_platform_update_domain_count" {
  description = "Number of update domains for the Linux availability set"
  type        = number
}

variable "linux_public_ip_allocation_method" {
  description = "Allocation method for Linux VM public IP addresses"
  type        = string
}

variable "linux_public_ip_sku" {
  description = "SKU for Linux VM public IP addresses"
  type        = string
}

variable "linux_private_ip_address_allocation" {
  description = "Private IP allocation method for Linux VM NICs"
  type        = string
}

variable "linux_os_disk_caching" {
  description = "Caching mode for Linux VM operating system disks"
  type        = string
}

variable "linux_os_disk_storage_account_type" {
  description = "Storage account type for Linux VM operating system disks"
  type        = string
}

variable "linux_image_publisher" {
  description = "Publisher of the Linux VM image"
  type        = string
}

variable "linux_image_offer" {
  description = "Offer of the Linux VM image"
  type        = string
}

variable "linux_image_sku" {
  description = "SKU of the Linux VM image"
  type        = string
}

variable "linux_image_version" {
  description = "Version of the Linux VM image"
  type        = string
}

# Windows VM parameterization

variable "windows_admin_password" {
  description = "Admin password for Windows VM"
  type        = string
  sensitive   = true
}

variable "windows_vm_count" {
  description = "Number of Windows VMs to create using count"
  type        = number
}

variable "windows_availability_set_name" {
  description = "Name of the Windows availability set"
  type        = string
}

variable "windows_platform_fault_domain_count" {
  description = "Number of fault domains for the Windows availability set"
  type        = number
}

variable "windows_platform_update_domain_count" {
  description = "Number of update domains for the Windows availability set"
  type        = number
}

variable "windows_public_ip_allocation_method" {
  description = "Allocation method for Windows VM public IP addresses"
  type        = string
}

variable "windows_public_ip_sku" {
  description = "SKU for Windows VM public IP addresses"
  type        = string
}

variable "windows_private_ip_address_allocation" {
  description = "Private IP allocation method for Windows VM NICs"
  type        = string
}

variable "windows_dns_label_prefix" {
  description = "DNS label prefix for Windows VM public IP addresses"
  type        = string
}

variable "windows_computer_name_prefix" {
  description = "Computer name prefix for Windows VMs"
  type        = string
}

variable "windows_os_disk_caching" {
  description = "Caching mode for Windows VM operating system disks"
  type        = string
}

variable "windows_os_disk_storage_account_type" {
  description = "Storage account type for Windows VM operating system disks"
  type        = string
}

variable "windows_image_publisher" {
  description = "Publisher of the Windows VM image"
  type        = string
}

variable "windows_image_offer" {
  description = "Offer of the Windows VM image"
  type        = string
}

variable "windows_image_sku" {
  description = "SKU of the Windows VM image"
  type        = string
}

variable "windows_image_version" {
  description = "Version of the Windows VM image"
  type        = string
}

# Data disk configuration

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

# PostgreSQL configuration

variable "postgres_server_name" {
  description = "Name of the PostgreSQL Flexible Server"
  type        = string
}

variable "postgres_admin_username" {
  description = "PostgreSQL administrator username"
  type        = string
}

variable "postgres_admin_password" {
  description = "PostgreSQL administrator password"
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
variable "lb_domain_name_label" {
  description = "DNS label for the load balancer public IP"
  type        = string
}
