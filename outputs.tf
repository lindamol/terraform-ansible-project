output "resource_group_name" {
  description = "Resource group name from rgroup module"
  value       = module.rgroup.resource_group_name
}

output "resource_group_location" {
  description = "Resource group location from rgroup module"
  value       = module.rgroup.resource_group_location
}

output "vnet_name" {
  description = "Virtual network name from network module"
  value       = module.network.vnet_name
}

output "subnet_name" {
  description = "Subnet name from network module"
  value       = module.network.subnet_name
}

output "nsg_name" {
  description = "Network security group name from network module"
  value       = module.network.nsg_name
}

output "log_analytics_name" {
  description = "Log Analytics Workspace name from common module"
  value       = module.common.log_analytics_name
}

output "recovery_vault_name" {
  description = "Recovery Services Vault name from common module"
  value       = module.common.recovery_vault_name
}

output "common_storage_account_name" {
  description = "Storage Account name from common module"
  value       = module.common.storage_account_name
}

output "linux_hostnames" {
  description = "Linux VM hostnames"
  value       = module.vmlinux.linux_hostnames
}

output "linux_fqdns" {
  description = "Linux VM FQDNs"
  value       = module.vmlinux.linux_fqdns
}

output "linux_private_ips" {
  description = "Linux VM private IP addresses"
  value       = module.vmlinux.linux_private_ips
}

output "linux_public_ips" {
  description = "Linux VM public IP addresses"
  value       = module.vmlinux.linux_public_ips
}

output "windows_hostnames" {
  description = "Windows VM hostnames"
  value       = module.vmwindows.windows_hostnames
}

output "windows_fqdns" {
  description = "Windows VM FQDNs"
  value       = module.vmwindows.windows_fqdns
}

output "windows_private_ips" {
  description = "Windows VM private IP addresses"
  value       = module.vmwindows.windows_private_ips
}

output "windows_public_ips" {
  description = "Windows VM public IP addresses"
  value       = module.vmwindows.windows_public_ips
}

output "data_disk_names" {
  description = "Data disk names from datadisk module"
  value       = module.datadisk.data_disk_names
}

output "load_balancer_name" {
  description = "Load Balancer name from loadbalancer module"
  value       = module.loadbalancer.load_balancer_name
}

output "load_balancer_public_ip" {
  description = "Load Balancer public IP"
  value       = module.loadbalancer.load_balancer_public_ip
}

output "database_server_name" {
  description = "Database server name from database module"
  value       = module.database.database_server_name
}

output "database_server_fqdn" {
  description = "Database server FQDN from database module"
  value       = module.database.database_server_fqdn
}
