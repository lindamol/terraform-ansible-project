terraform {
  backend "azurerm" {
    resource_group_name  = "6909-tfstate-rg"
    storage_account_name = "tfstate6909linda01"
    container_name       = "tfstate"
    key                  = "assignment1-n01276909.tfstate"
  }
}
