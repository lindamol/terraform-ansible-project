locals {
  all_vm_ids = merge(var.linux_vm_ids, var.windows_vm_ids)
}

resource "azurerm_managed_disk" "data_disk" {
  for_each = local.all_vm_ids

  name                 = "${var.resource_prefix}-${each.key}-datadisk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.data_disk_storage_account_type
  create_option        = var.data_disk_create_option
  disk_size_gb         = var.data_disk_size_gb
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  for_each = local.all_vm_ids

  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = each.value
  lun                = var.data_disk_lun
  caching            = var.data_disk_caching
}