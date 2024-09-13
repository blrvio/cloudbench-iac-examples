
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Verifique se o provedor é compatível com o recurso desejado
}

# Crie um perfil do Traffic Manager
resource "azurerm_traffic_manager_profile" "example" {
  name     = "example-profile"
  resource_group_name = "example-resources"
  dns_config {
    relative_name = "example"
    ttl            = 30
  }
  monitor_config {
    protocol  = "HTTP"
    port      = 80
    path      = "/"
    interval  = 30
    timeout   = 10
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }

  # Defina o método de roteamento
  # Opções: "Performance", "Priority", "Weighted", "Geographic", "Subnet"
  routing_method = "Performance"
}

# Crie um endpoint do Traffic Manager
resource "azurerm_traffic_manager_endpoint" "example" {
  name     = "example-endpoint"
  profile_name    = azurerm_traffic_manager_profile.example.name
  resource_group_name = azurerm_traffic_manager_profile.example.resource_group_name
  type     = "AzureEndpoints"
  target   = "https://example.azurewebsites.net"
}

    