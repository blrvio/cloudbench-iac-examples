
    # Configure the AzureRM provider
provider "azurerm" {
  features {} # Use the latest AzureRM provider features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create a logic app
resource "azurerm_logic_app" "example" {
  name                = "example-logic-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Create the logic app with the provided definition
  location            = azurerm_resource_group.example.location
  location            = azurerm_resource_group.example.location
  # Create the logic app with the provided definition
  definition = <<EOF
{
  "$schema": "https://schema.management.azure.com/schemas/2015-08-01/logicappdefinition.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "actions": [],
  "outputs": {}
}
EOF
}

# Create a logic app workflow
resource "azurerm_logic_app_workflow" "example" {
  name                = "example-workflow"
  resource_group_name = azurerm_resource_group.example.name
  logic_app_name      = azurerm_logic_app.example.name
  definition = <<EOF
{
  "$schema": "https://schema.management.azure.com/schemas/2015-08-01/workflowdefinition.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "actions": [],
  "outputs": {}
}
EOF
}

  