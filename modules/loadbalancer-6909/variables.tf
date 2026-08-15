variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_prefix" {
  description = "Last 4 digits of Humber ID"
  type        = string
}

variable "linux_nic_ids" {
  description = "Linux NIC IDs"
  type        = map(string)
}

variable "linux_nic_ip_config_names" {
  description = "Linux NIC IP configuration names"
  type        = map(string)
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}

variable "lb_domain_name_label" {
  description = "DNS label for the load balancer public IP"
  type        = string
}
