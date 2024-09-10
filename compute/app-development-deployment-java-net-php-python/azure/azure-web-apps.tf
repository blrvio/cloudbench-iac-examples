
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all Azure features
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "westus2"
}

# Create an Azure App Service Plan
resource "azurerm_app_service_plan" "main" {
  name     = "my-app-service-plan"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

# Create an Azure Web App
resource "azurerm_app_service" "main" {
  name                 = "my-web-app"
  location             = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id  = azurerm_app_service_plan.main.id
  # Optional settings for the web app
  # site_config {
  #   app_settings = {
  #     "WEBSITE_NODE_DEFAULT_VERSION" = "8.17.0"
  #   }
  # }
}

  