
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Ensure all features are enabled
}

# Create a Communication Service
resource "azurerm_communication_service" "main" {
  name                = "my-communication-service"
  location            = "westus2"
  resource_group_name = "my-resource-group"
}

# Create a Communication Service Connection
resource "azurerm_communication_service_connection" "main" {
  name                = "my-communication-service-connection"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  communication_service_id = azurerm_communication_service.main.id
}

# Create a Communication Service Endpoint
resource "azurerm_communication_service_endpoint" "main" {
  name                = "my-communication-service-endpoint"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  communication_service_connection_id = azurerm_communication_service_connection.main.id
  endpoint_type          = "sms"
}

  