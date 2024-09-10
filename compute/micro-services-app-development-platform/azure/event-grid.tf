
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Event Grid Topic
resource "azurerm_eventgrid_topic" "example" {
  name                = "example-topic"
  resource_group_name = "example-resources"
  location            = "westus2"
}

# Create an Event Grid Subscription
resource "azurerm_eventgrid_subscription" "example" {
  topic_name          = azurerm_eventgrid_topic.example.name
  resource_group_name = azurerm_eventgrid_topic.example.resource_group_name
  endpoint            = "https://example.com/webhook"
  # Set the event types you want to receive notifications for
  event_types = ["Microsoft.Storage.BlobCreated"]
}

  