
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "eastus"
}

# Create a Public IP Address
resource "azurerm_public_ip" "main" {
  name     = "my-public-ip"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method = "Static"
}

# Create a Load Balancer
resource "azurerm_lb" "main" {
  name     = "my-load-balancer"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    name = "Standard"
  }
  frontend_ip_configurations {
    name = "my-frontend-ip"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

# Create a Load Balancer Backend Pool
resource "azurerm_lb_backend_address_pool" "main" {
  name     = "my-backend-pool"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id = azurerm_lb.main.id
}

# Create a Load Balancer Rule
resource "azurerm_lb_rule" "main" {
  name     = "my-load-balancer-rule"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id = azurerm_lb.main.id
  frontend_port = 80
  backend_port = 80
  protocol = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
  probe_id = azurerm_lb_probe.main.id
}

# Create a Load Balancer Probe
resource "azurerm_lb_probe" "main" {
  name     = "my-load-balancer-probe"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id = azurerm_lb.main.id
  protocol = "Tcp"
  port = 80
  interval_in_seconds = 5
  timeout_in_seconds = 2
  unhealthy_threshold = 2
  healthy_threshold = 2
}

  