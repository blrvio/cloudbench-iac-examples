
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Logic App
resource "azurerm_logic_app" "example" {
  name                = "example-logic-app"
  location            = "westus2"
  resource_group_name = "example-resource-group"
  # Define the workflow of the Logic App
  definition = <<EOF
{
  "$schema": "https://schema.management.azure.com/schemas/2019-05-01/logic-app.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "actions": [
    {
      "type": "Http",
      "inputs": {
        "method": "GET",
        "uri": "https://example.com"
      },
      "runAfter": {}
    }
  ],
  "outputs": {}
}
EOF
}

# Create a Logic App Workflow Definition
resource "azurerm_logic_app_workflow" "example" {
  name                = "example-workflow"
  resource_group_name = "example-resource-group"
  location            = "westus2"
  logic_app_name     = azurerm_logic_app.example.name
  # Define the workflow definition
  definition = <<EOF
{
  "$schema": "https://schema.management.azure.com/schemas/2019-05-01/logic-app.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "actions": [
    {
      "type": "Http",
      "inputs": {
        "method": "GET",
        "uri": "https://example.com"
      },
      "runAfter": {}
    }
  ],
  "outputs": {}
}
EOF
}

  