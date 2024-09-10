
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Event Grid Topic
resource "azurerm_event_grid_topic" "example" {
  name                = "example-topic"
  resource_group_name = "example-resources"
  location            = "westus2"
}

# Create an Event Grid Subscription
resource "azurerm_event_grid_subscription" "example" {
  topic_id           = azurerm_event_grid_topic.example.id
  resource_group_name = "example-resources"
  event_type         = "Microsoft.Storage.Blob.Created"
  endpoint            = "https://example.webhook.com"
}

# Create an Event Grid System Topic
resource "azurerm_event_grid_system_topic" "example" {
  name                = "example-system-topic"
  resource_group_name = "example-resources"
  location            = "westus2"
  source              = "Microsoft.Storage.Blob"
  event_type          = "Microsoft.Storage.Blob.Created"
}

# Create an Event Grid System Topic Event Subscription
resource "azurerm_event_grid_system_topic_event_subscription" "example" {
  system_topic_name    = azurerm_event_grid_system_topic.example.name
  resource_group_name  = "example-resources"
  endpoint              = "https://example.webhook.com"
  event_type            = "Microsoft.Storage.Blob.Created"
  subject_begins_with = "example"
}

  