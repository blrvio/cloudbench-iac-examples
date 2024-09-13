
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Ativar recursos experimentais
}

# Crie um recurso de serviço de bot
resource "azurerm_bot_service" "example" {
  location          = "westus2"
  name              = "example-bot"
  resource_group_name = "example-resources"
  sku {
    name     = "F0"
    tier     = "Free"
  }

  # Define os canais para o bot
  channels {
    # Adicione canais como WebChat, DirectLine, etc.
  }
}

# Crie uma chave de canal DirectLine
resource "azurerm_bot_channel_direct_line" "example" {
  location          = "westus2"
  name              = "example-direct-line"
  bot_service_name = azurerm_bot_service.example.name
  resource_group_name = "example-resources"

  # Configuração de canal DirectLine (opcional)
  # ...
}
    