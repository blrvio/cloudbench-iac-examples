
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-mobile-apps-rg"
  location = "westus2"
}

# Create an App Service Plan
resource "azurerm_app_service_plan" "example" {
  name     = "example-mobile-apps-plan"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

# Create an App Service
resource "azurerm_app_service" "example" {
  name                = "example-mobile-apps"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  # Enable App Service Mobile Apps
  kind                = "functionapp,mobileapp"
}

# Create a Mobile App Backend
resource "azurerm_mobile_app_backend" "example" {
  name = "example-mobile-apps-backend"
  resource_group_name = azurerm_resource_group.example.name
  app_service_name   = azurerm_app_service.example.name
  location = azurerm_resource_group.example.location
  # Set the backend to use the current App Service
  app_service_plan_id = azurerm_app_service_plan.example.id
}

# Create a Mobile App Backend table
resource "azurerm_mobile_app_backend_table" "example" {
  name                 = "example-table"
  resource_group_name = azurerm_resource_group.example.name
  app_service_name   = azurerm_app_service.example.name
  backend_id         = azurerm_mobile_app_backend.example.id
}

  