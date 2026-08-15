output "windows_hostnames" {
  description = "Windows VM hostnames"
  value = {
    for index, vm in azurerm_windows_virtual_machine.windows_vm : "windows${index + 1}" => vm.computer_name
  }
}

output "windows_fqdns" {
  description = "Windows VM FQDNs"
  value = {
    for index, pip in azurerm_public_ip.windows_pip : "windows${index + 1}" => pip.fqdn
  }
}

output "windows_private_ips" {
  description = "Windows private IP addresses"
  value = {
    for index, nic in azurerm_network_interface.windows_nic : "windows${index + 1}" => nic.private_ip_address
  }
}

output "windows_public_ips" {
  description = "Windows public IP addresses"
  value = {
    for index, pip in azurerm_public_ip.windows_pip : "windows${index + 1}" => pip.ip_address
  }
}

output "windows_vm_ids" {
  description = "Windows VM IDs"
  value = {
    for index, vm in azurerm_windows_virtual_machine.windows_vm : "windows${index + 1}" => vm.id
  }
}

output "windows_availability_set_name" {
  description = "Windows availability set name"
  value       = azurerm_availability_set.windows_avset.name
}
