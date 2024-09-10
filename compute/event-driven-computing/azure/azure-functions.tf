
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable features for the Azure provider
}

# Create a resource group for Azure Functions
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create an Azure Functions app
resource "azurerm_function_app" "example" {
  name                 = "example-app"
  location             = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  storage_account_name = "example-storage"
  # ... other optional settings
}

# Create a function inside the Azure Functions app
resource "azurerm_function_app_function" "example" {
  name                 = "example-function"
  app_name              = azurerm_function_app.example.name
  resource_group_name = azurerm_resource_group.example.name
  # ... other optional settings
  # ... code for the function
}

  