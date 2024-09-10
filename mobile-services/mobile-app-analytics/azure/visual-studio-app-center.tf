
    # Configure the AzureRM provider
provider "azurerm" {
  features {} # This will ensure latest features are used
}

# Create an Azure App Service plan
resource "azurerm_app_service_plan" "app_service_plan" {
  name     = "app-service-plan"
  location = "westus2"
  resource_group_name = "app-service-plan-rg"
  sku {
    tier = "Free"
    size = "F1"
  }
}

# Create an Azure App Service
resource "azurerm_app_service" "app_service" {
  name                = "app-service"
  location            = "westus2"
  resource_group_name = "app-service-rg"
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}

# Configure App Center Build Service
resource "azurerm_app_center_build_service" "build_service" {
  name               = "build-service"
  resource_group_name = "app-center-rg"
  location            = "westus2"
  # ... other configuration
}

# Configure App Center distribution service
resource "azurerm_app_center_distribution_service" "distribution_service" {
  name               = "distribution-service"
  resource_group_name = "app-center-rg"
  location            = "westus2"
  # ... other configuration
}

# Configure App Center user
resource "azurerm_app_center_user" "user" {
  name               = "app-center-user"
  resource_group_name = "app-center-rg"
  location            = "westus2"
  # ... other configuration
}
  