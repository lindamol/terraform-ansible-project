variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resource group"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
