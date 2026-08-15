resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.resource_prefix}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = var.lb_domain_name_label
  tags                = var.tags
}

resource "azurerm_lb" "lb" {
  name                = "${var.resource_prefix}-LB"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "${var.resource_prefix}-lb-frontend"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "${var.resource_prefix}-lb-backend-pool"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "linux_lb_assoc" {
  for_each = var.linux_nic_ids

  network_interface_id    = each.value
  ip_configuration_name   = var.linux_nic_ip_config_names[each.key]
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

resource "azurerm_lb_probe" "http_probe" {
  name            = "${var.resource_prefix}-http-probe"
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "http_rule" {
  name                           = "${var.resource_prefix}-http-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${var.resource_prefix}-lb-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
}
