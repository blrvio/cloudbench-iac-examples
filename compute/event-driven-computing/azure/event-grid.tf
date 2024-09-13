
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use features para ativar novas funcionalidades do provedor
}

# Crie um tópico do Event Grid
resource "azurerm_eventgrid_topic" "example" {
  name                = "example-topic"
  location            = "westus2"
  resource_group_name = "example-resources"
}

# Crie uma regra de assinatura do Event Grid
resource "azurerm_eventgrid_event_subscription" "example" {
  topic_name         = azurerm_eventgrid_topic.example.name
  resource_group_name = azurerm_eventgrid_topic.example.resource_group_name
  event_type         = "Microsoft.Storage.BlobCreated"
  endpoint            = "https://example.com/webhook"
  dead_letter_endpoint = "https://example.com/deadletter"
}

    