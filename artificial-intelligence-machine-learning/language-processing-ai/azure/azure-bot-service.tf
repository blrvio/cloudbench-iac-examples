
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enables all features, including new experimental features
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create an Azure Bot Service
resource "azurerm_bot_service" "example" {
  name                 = "example-bot"
  location              = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  sku_name              = "F0"
  # Optional: Enable Application Insights
  application_insights_key = "<application_insights_key>"
  # Optional: Enable Conversation Logging
  is_conversation_logging_enabled = false
  # Optional: Set the Bot Service Endpoint
  endpoint = "<endpoint>"
  # Optional: Set the Bot Service SKU Tier
  sku_tier = "Free"
}

# Create an Azure Bot Connection
resource "azurerm_bot_connection" "example" {
  name                 = "example-connection"
  resource_group_name  = azurerm_resource_group.example.name
  bot_service_name     = azurerm_bot_service.example.name
  connection_type       = "Microsoft.Azure.Management.BotService.ChannelConnectionType.DirectLine"
  # Optional: Set the Connection Properties
  properties            = {
    #  Properties are dependent on the Connection Type
  }
}

  