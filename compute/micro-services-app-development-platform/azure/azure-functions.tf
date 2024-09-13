
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Enable features
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "West Europe"
}

# Crie uma função do Azure
resource "azurerm_function_app" "example" {
  name                = "example-function-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  storage_account_name = "example-storage-account" # Substitua pelo nome da conta de armazenamento
  app_service_plan_id = "example-app-service-plan" # Substitua pelo ID do plano de serviço de aplicativo

  # Crie um ponto de extremidade HTTP
  https_config {
    routes {
      route_prefix = "/api"
    }
  }
}

# Crie um script de função
resource "azurerm_function_app_function" "example" {
  name            = "example-function"
  function_app_id = azurerm_function_app.example.id
  script_file     = "function.js" # Substitua pelo caminho para o arquivo de script
  entry_point     = "httpTrigger"
}

# Crie uma função HTTP
resource "azurerm_function_app_function" "http_trigger" {
  name            = "httpTrigger"
  function_app_id = azurerm_function_app.example.id
  script_file     = "function.js" # Substitua pelo caminho para o arquivo de script
  entry_point     = "httpTrigger"

  # Configure a autorização anônima
  config {
    auth_level = "anonymous"
  }
}
    