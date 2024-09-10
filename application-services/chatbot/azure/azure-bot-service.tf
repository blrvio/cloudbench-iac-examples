
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Optional: Enable specific Azure features
}

# Create a Bot Service
resource "azurerm_bot_service" "example" {
  name                = "example-bot"
  location            = "westus2"
  resource_group_name = "example-resources"
  sku {
    name = "F0"
  }
}

# Create a Channel Connection
resource "azurerm_bot_channel" "example" {
  name                = "example-channel"
  location            = "westus2"
  resource_group_name = "example-resources"
  bot_service_name    = azurerm_bot_service.example.name
  channel_type        = "emulator"
}

# Create a Bot Connection
resource "azurerm_bot_connection" "example" {
  name                = "example-connection"
  location            = "westus2"
  resource_group_name = "example-resources"
  bot_service_name    = azurerm_bot_service.example.name
  connection_type     = "luis"
  properties {
    luis_app_id = "your-luis-app-id"
    luis_key     = "your-luis-app-key"
  }
}

# Create a Bot Endpoint
resource "azurerm_bot_endpoint" "example" {
  name                = "example-endpoint"
  location            = "westus2"
  resource_group_name = "example-resources"
  bot_service_name    = azurerm_bot_service.example.name
  endpoint_type        = "production"
}

  