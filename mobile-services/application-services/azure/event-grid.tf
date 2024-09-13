
      # Configure o provedor do Azure
provider "azurerm" {
  features {} 
}

# Crie um tópico do Event Grid
resource "azurerm_eventgrid_topic" "example" {
  name                = "example-topic"
  resource_group_name = "example-resource-group"
  location            = "westus2"
}

# Crie uma assinatura do Event Grid
resource "azurerm_eventgrid_event_subscription" "example" {
  topic_name       = azurerm_eventgrid_topic.example.name
  resource_group_name = azurerm_eventgrid_topic.example.resource_group_name
  event_type        = "Microsoft.Storage.Blob.Created"
  endpoint          = "https://example.com/webhook"
}

    