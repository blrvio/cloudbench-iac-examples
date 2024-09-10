
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable features for Azure resources
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "my-resource-group"
  location = "westus2"
}

# Create an Azure Function App
resource "azurerm_function_app" "example" {
  name                = "my-function-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Configure storage account connection for the Function App
  storage_account_name  = "my-storage-account"
  storage_account_key = "YOUR_STORAGE_ACCOUNT_KEY"
  # Enable application insights
  app_insights_instrumentation_key = "YOUR_APP_INSIGHTS_INSTRUMENTATION_KEY"
  # Other configurations
  # ...
}

# Create an Azure Function
resource "azurerm_function_app_function" "example" {
  name                = "my-function"
  function_app_name  = azurerm_function_app.example.name
  resource_group_name = azurerm_resource_group.example.name
  # Function configuration
  # ...
  # Define the function code
  script_file = "index.js"
  # Add tags to the function
  tags = {
    Environment = "dev"
  }
}

  