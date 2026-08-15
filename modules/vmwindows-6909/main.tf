resource "azurerm_availability_set" "windows_avset" {
  name                         = var.availability_set_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  managed                      = true
  tags                         = var.tags
}

resource "azurerm_public_ip" "windows_pip" {
  count = var.windows_vm_count

  name                = "${var.resource_prefix}-windows-vm${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  domain_name_label   = "${var.dns_label_prefix}${count.index + 1}"
  tags                = var.tags
}

resource "azurerm_network_interface" "windows_nic" {
  count = var.windows_vm_count

  name                = "${var.resource_prefix}-windows-vm${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "${var.resource_prefix}-windows-vm${count.index + 1}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.windows_pip[count.index].id
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count = var.windows_vm_count

  name                  = "${var.resource_prefix}-windows-vm${count.index + 1}"
  computer_name         = "${var.computer_name_prefix}${count.index + 1}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  availability_set_id   = azurerm_availability_set.windows_avset.id
  network_interface_ids = [azurerm_network_interface.windows_nic[count.index].id]
  tags                  = var.tags

  os_disk {
    name                 = "${var.resource_prefix}-windows-vm${count.index + 1}-osdisk"
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

resource "azurerm_virtual_machine_extension" "antimalware" {
  count = var.windows_vm_count

  name                       = "IaaSAntimalware"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows_vm[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    AntimalwareEnabled        = true
    RealtimeProtectionEnabled = true

    ScheduledScanSettings = {
      isEnabled = true
      day       = 7
      time      = 120
      scanType  = "Quick"
    }
  })
}