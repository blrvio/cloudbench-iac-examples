
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Optional: enable specific features
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create an Azure Container Registry
resource "azurerm_container_registry" "example" {
  name                = "example-acr"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                  = "Basic"
  # Optional settings
  admin_user_enabled = false
  # ... more settings
}

# Create a Container Registry Task
# (This is an example, adjust based on your needs)
resource "azurerm_container_registry_task" "example" {
  name                = "example-task"
  resource_group_name = azurerm_resource_group.example.name
  registry_name      = azurerm_container_registry.example.name
  # ... more settings
}

# Create a Container Registry Webhook
# (This is an example, adjust based on your needs)
resource "azurerm_container_registry_webhook" "example" {
  name                = "example-webhook"
  resource_group_name = azurerm_resource_group.example.name
  registry_name      = azurerm_container_registry.example.name
  # ... more settings
}
  