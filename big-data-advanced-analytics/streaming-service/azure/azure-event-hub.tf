
    # Configure the Azure Provider
provider "azurerm" {
  features {} # This can be used to enable preview features
}

# Create an Azure Event Hub Namespace
resource "azurerm_eventhub_namespace" "main" {
  name                = "my-event-hub-namespace"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  sku {
    name     = "Standard"
    tier     = "Standard"
    capacity = 1
  }
}

# Create an Azure Event Hub
resource "azurerm_eventhub" "main" {
  name                = "my-event-hub"
  namespace_name      = azurerm_eventhub_namespace.main.name
  location            = azurerm_eventhub_namespace.main.location
  resource_group_name = azurerm_eventhub_namespace.main.resource_group_name
  partition_count     = 2
  message_retention_in_days = 7
}

# Create an Azure Event Hub Consumer Group
resource "azurerm_eventhub_consumer_group" "main" {
  name                = "my-consumer-group"
  namespace_name      = azurerm_eventhub_namespace.main.name
  eventhub_name       = azurerm_eventhub.main.name
  location            = azurerm_eventhub_namespace.main.location
  resource_group_name = azurerm_eventhub_namespace.main.resource_group_name
}

  