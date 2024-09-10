
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable experimental features
}

# Create a Service Bus Namespace
resource "azurerm_servicebus_namespace" "main" {
  name                = "my-servicebus-namespace"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  sku                  = "Standard"
}

# Create a Service Bus Queue
resource "azurerm_servicebus_queue" "main" {
  name                = "my-queue"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = azurerm_servicebus_namespace.main.resource_group_name
  max_delivery_count  = 10
  default_message_ttl = 3600
}

# Create a Service Bus Topic
resource "azurerm_servicebus_topic" "main" {
  name                = "my-topic"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = azurerm_servicebus_namespace.main.resource_group_name
}

# Create a Service Bus Subscription
resource "azurerm_servicebus_subscription" "main" {
  name                = "my-subscription"
  topic_name          = azurerm_servicebus_topic.main.name
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = azurerm_servicebus_namespace.main.resource_group_name
  max_delivery_count  = 10
  default_message_ttl = 3600
}

  