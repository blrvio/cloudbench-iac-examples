
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Web PubSub service
resource "azurerm_web_pubsub" "example" {
  name                = "my-webpubsub-service"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  # Optional settings
  # sku                 = "Standard"
  # capacity             = 1
}

# Create a Web PubSub Hub
resource "azurerm_web_pubsub_hub" "example" {
  name                = "my-hub"
  web_pubsub_name      = azurerm_web_pubsub.example.name
  resource_group_name = azurerm_web_pubsub.example.resource_group_name
  # Optional settings
  # event_handler_endpoint = "my-event-handler-endpoint"
}

# Create a Web PubSub Connection string
resource "azurerm_web_pubsub_connection_string" "example" {
  name                = "my-connection-string"
  web_pubsub_name      = azurerm_web_pubsub.example.name
  resource_group_name = azurerm_web_pubsub.example.resource_group_name
}

  