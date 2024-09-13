
      # Configure the Azure Provider
provider "azurerm" {
  features {} # Ensure you have the latest features
}

# Create a Communication Services resource
resource "azurerm_communication_service" "example" {
  name                = "example-communication-service"
  location            = "westus2"
  resource_group_name = "example-resource-group"
}

# Create a Phone Number
resource "azurerm_communication_service_phone_number" "example" {
  communication_service_name = azurerm_communication_service.example.name
  phone_number           = "+14255550123" # Replace with a valid phone number
  location               = azurerm_communication_service.example.location
  resource_group_name     = azurerm_communication_service.example.resource_group_name
}

# Create an Email Service
resource "azurerm_communication_service_email_service" "example" {
  name                = "example-email-service"
  location            = "westus2"
  resource_group_name = "example-resource-group"
  communication_service_name = azurerm_communication_service.example.name
}
    