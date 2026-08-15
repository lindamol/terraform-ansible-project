output "load_balancer_name" {
  description = "Name of the load balancer"
  value       = azurerm_lb.lb.name
}

output "load_balancer_public_ip" {
  description = "Public IP address of the load balancer"
  value       = azurerm_public_ip.lb_pip.ip_address
}

output "load_balancer_backend_pool_name" {
  description = "Name of the load balancer backend pool"
  value       = azurerm_lb_backend_address_pool.backend_pool.name
}
