
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "eastus"
}

# Create an App Service Environment
resource "azurerm_app_service_environment" "main" {
  name                  = "my-ase"
  location              = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  pricing_tier         = "Isolated"
}

# Create an App Service Plan
resource "azurerm_app_service_plan" "main" {
  name                  = "my-app-service-plan"
  location              = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    tier         = "Free"
    size         = "F1"
    family       = "F"
    capacity     = 1
    worker_size   = "Small"
    worker_count  = 1
    premium_app_count = 1
  }
  kind = "app,linux"
  # Associate the app service plan to the App Service Environment
  app_service_environment_id = azurerm_app_service_environment.main.id
}

# Create an App Service
resource "azurerm_app_service" "main" {
  name                  = "my-app-service"
  location              = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id
  # Specify the runtime stack
  runtime_stack {
    name = "DOTNETCORE|3.1"
  }
}

  