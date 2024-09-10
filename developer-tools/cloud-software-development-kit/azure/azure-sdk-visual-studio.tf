
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "westus2"
}

# Create a Service Principal for Authentication
resource "azurerm_service_principal" "main" {
  application_id = "your-application-id"
  name           = "my-service-principal"
  # For example, the Azure Active Directory application you've registered
}

# Configure the Application Settings
resource "azurerm_app_service_plan" "main" {
  name     = "my-app-service-plan"
  location = "westus2"
  resource_group_name = azurerm_resource_group.main.name
  sku {
    tier       = "Free"
    size       = "F1"
    family     = "Free"
  }
}

# Create an App Service
resource "azurerm_app_service" "main" {
  name                = "my-app-service"
  location            = "westus2"
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id
  # Other app service configuration can be provided here
}

# Output the App Service details
output "app_service_url" {
  value = azurerm_app_service.main.default_site_hostname
}

  