
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Adicionar recursos avançados
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe"
}

# Crie um registro de contêiner
resource "azurerm_container_registry" "example" {
  name                = "example-acr"
  resource_group_name = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  sku                  = "Basic"
  admin_user_enabled  = false
}

# Crie um repositório de contêiner
resource "azurerm_container_registry_repository" "example" {
  name                = "example-repo"
  registry_name       = azurerm_container_registry.example.name
  resource_group_name = azurerm_resource_group.example.name
}

# Crie um segredo para armazenar a senha do repositório de contêiner
resource "azurerm_key_vault_secret" "example" {
  name         = "example-secret"
  value        = "example-password"
  resource_group_name = azurerm_resource_group.example.name
  key_vault_name  = "example-kv"
}

    