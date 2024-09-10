
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a resource group for your Web App
resource "azurerm_resource_group" "example" {
  name     = "my-resource-group"
  location = "westus2"
}

# Create an Azure App Service plan
resource "azurerm_app_service_plan" "example" {
  name                = "my-app-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier     = "Free"
    size     = "F1"
    family   = "F"
  }
}

# Create the Web App
resource "azurerm_app_service" "example" {
  name                = "my-web-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  # Other optional configuration options
}

  