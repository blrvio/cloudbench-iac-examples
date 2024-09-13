
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Para habilitar novas funcionalidades
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie um aplicativo de contêiner
resource "azurerm_container_app" "example" {
  name                = "example-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os                  = "linux"
  revision_template {
    containers {
      name  = "my-app"
      image = "mcr.microsoft.com/azuredocs/containerapps/sample"
    }
  }
}

# Crie um registro de contêiner
resource "azurerm_container_registry" "example" {
  name                = "example-registry"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                  = "Basic"
}
    