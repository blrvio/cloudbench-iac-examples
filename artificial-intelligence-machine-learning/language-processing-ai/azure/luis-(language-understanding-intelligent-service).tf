
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Habilita recursos beta
}

# Crie um recurso de LUIS
resource "azurerm_cognitive_services_account" "luis" {
  name                = "my-luis-account"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  kind                = "luis"
  sku {
    name     = "F0"
    tier     = "Free"
    capacity = 1
  }
}

# Crie um aplicativo LUIS
resource "azurerm_luis_app" "my-luis-app" {
  name                 = "my-luis-app"
  location             = azurerm_cognitive_services_account.luis.location
  resource_group_name = azurerm_cognitive_services_account.luis.resource_group_name
  cognitive_services_account_id = azurerm_cognitive_services_account.luis.id
}

# Crie um endpoint LUIS
resource "azurerm_luis_endpoint" "my-luis-endpoint" {
  name                 = "my-luis-endpoint"
  location             = azurerm_cognitive_services_account.luis.location
  resource_group_name = azurerm_cognitive_services_account.luis.resource_group_name
  cognitive_services_account_id = azurerm_cognitive_services_account.luis.id
  luis_app_id           = azurerm_luis_app.my-luis-app.id
  endpoint_type        = "authoring"
}

    