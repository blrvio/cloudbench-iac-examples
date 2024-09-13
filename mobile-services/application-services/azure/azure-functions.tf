
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Adicione recursos para ativar novas funcionalidades
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "westus2"
}

# Crie uma função do Azure
resource "azurerm_function_app" "example" {
  name                = "example-function-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  storage_account_name = "example-storage-account"
  app_service_plan_id  = "example-app-service-plan-id"

  # Configurações adicionais (como configurações de runtime e rede) podem ser adicionadas aqui
}

    