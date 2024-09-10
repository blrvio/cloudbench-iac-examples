
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create a notification hub
resource "azurerm_notification_hub" "example" {
  name                = "example-notification-hub"
  namespace_name     = "example-namespace"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # Optional: Configure the authorization rules for the notification hub
  authorization_rule {
    name    = "default"
    primary_key = "YOUR_PRIMARY_KEY"
    secondary_key = "YOUR_SECONDARY_KEY"
  }
}

# Create a connection string
resource "azurerm_notification_hub_connection_string" "example" {
  notification_hub_name = azurerm_notification_hub.example.name
  namespace_name       = azurerm_notification_hub.example.namespace_name
  resource_group_name    = azurerm_resource_group.example.name
  authorization_rule_name = "default"
}

# Output the connection string for the notification hub
output "connection_string" {
  value = azurerm_notification_hub_connection_string.example.primary_connection_string
}
  