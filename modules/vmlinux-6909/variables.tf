variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for Linux VMs"
  type        = string
}

variable "admin_username" {
  description = "Admin username for Linux VMs"
  type        = string
}

variable "vm_size" {
  description = "Linux VM size"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key for Linux VMs"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key used for Linux VM connectivity"
  type        = string
}

variable "linux_vms" {
  description = "Map containing Linux VM names, hostnames, and DNS labels"

  type = map(object({
    name      = string
    hostname  = string
    dns_label = string
  }))
}

variable "availability_set_name" {
  description = "Name of the Linux availability set"
  type        = string
}

variable "platform_fault_domain_count" {
  description = "Number of fault domains for the Linux availability set"
  type        = number
}

variable "platform_update_domain_count" {
  description = "Number of update domains for the Linux availability set"
  type        = number
}

variable "public_ip_allocation_method" {
  description = "Allocation method for Linux VM public IP addresses"
  type        = string
}

variable "public_ip_sku" {
  description = "SKU for Linux VM public IP addresses"
  type        = string
}

variable "private_ip_address_allocation" {
  description = "Private IP address allocation method for Linux VM NICs"
  type        = string
}

variable "os_disk_caching" {
  description = "Caching mode for Linux VM operating system disks"
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for Linux VM operating system disks"
  type        = string
}

variable "image_publisher" {
  description = "Publisher of the Linux VM image"
  type        = string
}

variable "image_offer" {
  description = "Offer of the Linux VM image"
  type        = string
}

variable "image_sku" {
  description = "SKU of the Linux VM image"
  type        = string
}

variable "image_version" {
  description = "Version of the Linux VM image"
  type        = string
}

variable "boot_diagnostics_storage_uri" {
  description = "Storage account blob endpoint used for Linux VM boot diagnostics"
  type        = string
}

variable "tags" {
  description = "Common tags applied to Linux resources"
  type        = map(string)
}