
      # Configure o provedor Azure
provider "azurerm" {
  features {} # habilita recursos mais recentes
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# Crie um balanceador de carga
resource "azurerm_lb" "example" {
  name                = "example-lb"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name = "example-frontend"
    # Sub-rede da sua rede virtual
    subnet_id = "subnet_id"
  }

  backend_address_pool {
    name = "example-pool"
  }
}

# Crie um conjunto de regras de balanceador de carga
resource "azurerm_lb_rule" "example" {
  name                = "example-rule"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  loadbalancer_id     = azurerm_lb.example.id

  frontend_port     = 80
  backend_port      = 80
  protocol          = "tcp"
  probe_id          = azurerm_lb_probe.example.id
  load_distribution = "Default"
}

# Crie uma sonda de integridade
resource "azurerm_lb_probe" "example" {
  name                = "example-probe"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  loadbalancer_id     = azurerm_lb.example.id

  protocol = "tcp"
  port     = 80
  interval = 5
  timeout  = 2
  unhealthy_threshold  = 2
  healthy_threshold = 2
}
    