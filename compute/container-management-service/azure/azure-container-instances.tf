
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Habilita recursos beta do Terraform
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie uma instância de contêiner
resource "azurerm_container_group" "example" {
  name                = "example-aci"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type            = "Linux"
  containers {
    name  = "nginx"
    image = "nginx:latest"
    ports {
      port     = 80
      protocol = "tcp"
    }
  }
  restart_policy = "Always"
}

# Expose a porta para acesso externo
resource "azurerm_container_group_outbound_port" "example" {
  container_group_name = azurerm_container_group.example.name
  resource_group_name  = azurerm_resource_group.example.name
  port                = 80
  protocol             = "tcp"
}
    