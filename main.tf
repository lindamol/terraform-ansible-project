module "rgroup" {
  source = "./modules/rgroup-6909"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.common_tags
}

module "network" {
  source = "./modules/network-6909"

  resource_group_name     = module.rgroup.resource_group_name
  location                = var.location
  vnet_name               = var.vnet_name
  subnet_name             = var.subnet_name
  nsg_name                = var.nsg_name
  vnet_address_space      = var.vnet_address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  nsg_rules               = var.nsg_rules
  tags                    = local.common_tags
}

module "common" {
  source = "./modules/common-6909"

  resource_group_name  = module.rgroup.resource_group_name
  location             = var.location
  log_analytics_name   = var.log_analytics_name
  recovery_vault_name  = var.recovery_vault_name
  storage_account_name = var.common_storage_account_name

  log_analytics_sku            = var.log_analytics_sku
  log_analytics_retention_days = var.log_analytics_retention_days
  recovery_vault_sku           = var.recovery_vault_sku

  storage_account_tier             = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
  storage_account_kind             = var.storage_account_kind

  tags = local.common_tags
}

module "vmlinux" {
  source = "./modules/vmlinux-6909"

  resource_group_name          = module.rgroup.resource_group_name
  location                     = var.location
  subnet_id                    = module.network.subnet_id
  admin_username               = var.admin_username
  vm_size                      = var.linux_vm_size
  ssh_public_key_path          = var.ssh_public_key_path
  ssh_private_key_path         = var.ssh_private_key_path
  boot_diagnostics_storage_uri = module.common.storage_account_primary_blob_endpoint
  linux_vms                    = var.linux_vms

  availability_set_name         = var.linux_availability_set_name
  platform_fault_domain_count   = var.linux_platform_fault_domain_count
  platform_update_domain_count  = var.linux_platform_update_domain_count
  public_ip_allocation_method   = var.linux_public_ip_allocation_method
  public_ip_sku                 = var.linux_public_ip_sku
  private_ip_address_allocation = var.linux_private_ip_address_allocation
  os_disk_caching               = var.linux_os_disk_caching
  os_disk_storage_account_type  = var.linux_os_disk_storage_account_type
  image_publisher               = var.linux_image_publisher
  image_offer                   = var.linux_image_offer
  image_sku                     = var.linux_image_sku
  image_version                 = var.linux_image_version

  tags = local.common_tags
}

module "vmwindows" {
  source = "./modules/vmwindows-6909"

  resource_group_name          = module.rgroup.resource_group_name
  location                     = var.location
  resource_prefix              = var.resource_prefix
  subnet_id                    = module.network.subnet_id
  admin_username               = var.admin_username
  admin_password               = var.windows_admin_password
  vm_size                      = var.windows_vm_size
  windows_vm_count             = var.windows_vm_count
  boot_diagnostics_storage_uri = module.common.storage_account_primary_blob_endpoint

  availability_set_name         = var.windows_availability_set_name
  platform_fault_domain_count   = var.windows_platform_fault_domain_count
  platform_update_domain_count  = var.windows_platform_update_domain_count
  public_ip_allocation_method   = var.windows_public_ip_allocation_method
  public_ip_sku                 = var.windows_public_ip_sku
  private_ip_address_allocation = var.windows_private_ip_address_allocation
  dns_label_prefix              = var.windows_dns_label_prefix
  computer_name_prefix          = var.windows_computer_name_prefix
  os_disk_caching               = var.windows_os_disk_caching
  os_disk_storage_account_type  = var.windows_os_disk_storage_account_type
  image_publisher               = var.windows_image_publisher
  image_offer                   = var.windows_image_offer
  image_sku                     = var.windows_image_sku
  image_version                 = var.windows_image_version

  tags = local.common_tags
}

module "datadisk" {
  source = "./modules/datadisk-6909"

  resource_group_name = module.rgroup.resource_group_name
  location            = var.location
  resource_prefix     = var.resource_prefix
  linux_vm_ids        = module.vmlinux.linux_vm_ids
  windows_vm_ids      = module.vmwindows.windows_vm_ids

  data_disk_storage_account_type = var.data_disk_storage_account_type
  data_disk_create_option        = var.data_disk_create_option
  data_disk_size_gb              = var.data_disk_size_gb
  data_disk_lun                  = var.data_disk_lun
  data_disk_caching              = var.data_disk_caching

  tags = local.common_tags
}

module "loadbalancer" {
  source = "./modules/loadbalancer-6909"

  resource_group_name  = module.rgroup.resource_group_name
  location             = var.location
  resource_prefix      = var.resource_prefix
  linux_nic_ids        = module.vmlinux.linux_nic_ids
  lb_domain_name_label = var.lb_domain_name_label

  linux_nic_ip_config_names = {
    for key, vm in var.linux_vms : key => "${vm.name}-ipconfig"
  }

  tags = local.common_tags
}

module "database" {
  source = "./modules/database-6909"

  resource_group_name    = module.rgroup.resource_group_name
  location               = var.location
  resource_prefix        = var.resource_prefix
  postgres_server_name   = var.postgres_server_name
  administrator_login    = var.postgres_admin_username
  administrator_password = var.postgres_admin_password

  postgresql_version                       = var.postgresql_version
  postgresql_sku_name                      = var.postgresql_sku_name
  postgresql_storage_mb                    = var.postgresql_storage_mb
  postgresql_backup_retention_days         = var.postgresql_backup_retention_days
  postgresql_geo_redundant_backup_enabled  = var.postgresql_geo_redundant_backup_enabled
  postgresql_public_network_access_enabled = var.postgresql_public_network_access_enabled

  tags = local.common_tags
}