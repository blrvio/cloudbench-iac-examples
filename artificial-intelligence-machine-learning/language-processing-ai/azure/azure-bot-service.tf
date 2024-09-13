
      # Configure o provedor Azure
provider "azurerm" {
  features {} # habilite recursos adicionais
}

# Crie um recurso de Bot Service
resource "azurerm_bot_service" "example" {
  name                = "example-bot-service"
  location            = "westus2"
  resource_group_name = "example-resource-group"
  sku {
    tier = "Free"
  }
}

# Crie um canal direto para o Bot Service
resource "azurerm_bot_channel_directline" "example" {
  bot_service_name = azurerm_bot_service.example.name
  location            = azurerm_bot_service.example.location
  resource_group_name = azurerm_bot_service.example.resource_group_name
}

    