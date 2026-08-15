output "data_disk_names" {
  description = "Names of the created data disks"
  value = {
    for key, disk in azurerm_managed_disk.data_disk : key => disk.name
  }
}
