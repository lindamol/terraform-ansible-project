resource "azurerm_availability_set" "linux_avset" {
  name                         = var.availability_set_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  managed                      = true
  tags                         = var.tags
}

resource "azurerm_public_ip" "linux_pip" {
  for_each = var.linux_vms

  name                = "${each.value.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  domain_name_label   = each.value.dns_label
  tags                = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  for_each = var.linux_vms

  name                = "${each.value.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "${each.value.name}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each = var.linux_vms

  name                            = each.value.name
  computer_name                   = each.value.hostname
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  availability_set_id             = azurerm_availability_set.linux_avset.id
  network_interface_ids           = [azurerm_network_interface.linux_nic[each.key].id]
  tags                            = var.tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    name                 = "${each.value.name}-osdisk"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_uri
  }
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  name                       = "NetworkWatcherAgentLinux"
  virtual_machine_id         = each.value.id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each = azurerm_linux_virtual_machine.linux_vm

  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = each.value.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}