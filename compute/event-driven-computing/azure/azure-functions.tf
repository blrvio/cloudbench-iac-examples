
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Ensure you're using the latest features
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie uma função Azure
resource "azurerm_function_app" "example" {
  name                = "example-function-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  storage_account_name = "example-storage-account"
  app_service_plan_id = "example-app-service-plan-id"

  #  Configuração do plano de hospedagem da função
  app_service_plan {
    sku {
      tier  = "Free"
      size  = "F1"
    }
  }

  # Configure as definições da função
  configuration {
    runtime = "python"
  }

  # Opcionalmente, configure a definição de versão da função
  # version {
  #   major = "3"
  #   minor = "0"
  #   patch = "0"
  # }
}

# Defina as configurações de uma função individual
resource "azurerm_function_app_function" "example" {
  name                = "example-function"
  function_app_name = azurerm_function_app.example.name
  resource_group_name = azurerm_resource_group.example.name
  script_file        = "example.py"
  entry_point         = "main"

  # Configuração da função
  config {
    # Configurações específicas da função (opcional)
    # ...
  }
}
    