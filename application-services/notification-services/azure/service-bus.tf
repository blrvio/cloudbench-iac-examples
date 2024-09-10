
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Service Bus Namespace
resource "azurerm_servicebus_namespace" "main" {
  name                = "my-servicebus-namespace"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  sku {
    name = "Standard"
  }
}

# Create a Queue within the Namespace
resource "azurerm_servicebus_queue" "main" {
  name                = "my-servicebus-queue"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = azurerm_servicebus_namespace.main.resource_group_name
  max_delivery_count  = 10
}

# Create a Topic within the Namespace
resource "azurerm_servicebus_topic" "main" {
  name                = "my-servicebus-topic"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = azurerm_servicebus_namespace.main.resource_group_name
  # Enable the topic to be partitioned
  enable_partitioning = true
}

# Create a Subscription to the Topic
resource "azurerm_servicebus_subscription" "main" {
  name                = "my-servicebus-subscription"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = azurerm_servicebus_namespace.main.resource_group_name
  topic_name          = azurerm_servicebus_topic.main.name
  # Enable the subscription to receive dead-letter messages
  enable_dead_lettering_on_message_expiration = true
}

  