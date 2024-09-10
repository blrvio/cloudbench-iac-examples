
    # Configure the Azure Provider
provider "azurerm" {
  features {}  
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "westus2"
}

# Create a storage account
resource "azurerm_storage_account" "example" {
  name                     = "example-storage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create an Azure Function App
resource "azurerm_function_app" "example" {
  name                = "example-function-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  storage_account_name = azurerm_storage_account.example.name
  app_service_plan_id  = azurerm_app_service_plan.example.id
}

# Create an App Service Plan
resource "azurerm_app_service_plan" "example" {
  name                = "example-app-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

# Create a Function
resource "azurerm_function_app_function" "example" {
  name                = "example-function"
  function_app_name = azurerm_function_app.example.name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  config {
    runtime = "python"
  }
  # Define the function code inline
  code = <<EOF
import logging

import azure.functions as func

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
    name = req.params.get('name')
    if name:
        return func.HttpResponse(f"Hello, {name}!", status_code=200)
    else:
        return func.HttpResponse(
            "Please pass a name on the query string or in the request body", 
            status_code=400
        )
EOF
}

  