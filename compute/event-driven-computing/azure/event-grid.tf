
    # Configure the Azure provider
provider "azurerm" {
  features {} # This is needed to enable newer features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "West Europe"
}

# Create an Event Grid topic
resource "azurerm_eventgrid_topic" "example" {
  name                = "example-eventgrid-topic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # Optional, you can define the input schema
  # input_schema {
  #   input_schema_mapping = "EventGridSchema"
  # }

  # Optional, you can define the input endpoint
  # input_endpoint {
  #   endpoint_type = "AzureFunction"
  #   # You can specify the function app name and function name
  #   function_app_name = "example-function-app"
  #   function_name      = "example-function"
  # }
}

# Create an Event Grid subscription
resource "azurerm_eventgrid_subscription" "example" {
  topic_id             = azurerm_eventgrid_topic.example.id
  source               = "Microsoft.Storage.Blob"
  subject_begins_with  = "my-storage-account"
  endpoint             = "https://example.com/api/events"
  event_types          = ["Microsoft.Storage.Blob.Created"]
  resource_group_name = azurerm_resource_group.example.name
}

  