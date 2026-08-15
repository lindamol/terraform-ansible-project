output "linux_hostnames" {
  description = "Linux VM hostnames"
  value = {
    for key, vm in azurerm_linux_virtual_machine.linux_vm : key => vm.computer_name
  }
}

output "linux_fqdns" {
  description = "Linux VM FQDNs"
  value = {
    for key, pip in azurerm_public_ip.linux_pip : key => pip.fqdn
  }
}

output "linux_private_ips" {
  description = "Linux VM private IP addresses"
  value = {
    for key, nic in azurerm_network_interface.linux_nic : key => nic.private_ip_address
  }
}

output "linux_public_ips" {
  description = "Linux VM public IP addresses"
  value = {
    for key, pip in azurerm_public_ip.linux_pip : key => pip.ip_address
  }
}

output "linux_vm_ids" {
  description = "Linux VM IDs"
  value = {
    for key, vm in azurerm_linux_virtual_machine.linux_vm : key => vm.id
  }
}

output "linux_nic_ids" {
  description = "Linux NIC IDs"
  value = {
    for key, nic in azurerm_network_interface.linux_nic : key => nic.id
  }
}

output "linux_availability_set_name" {
  description = "Linux availability set name"
  value       = azurerm_availability_set.linux_avset.name
}
