
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Verifique se o Azure Provider está atualizado
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe"
}

# Crie um aplicativo de lógica
resource "azurerm_logic_app" "example" {
  name                 = "example-logic-app"
  location             = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  # Defina o esquema do aplicativo de lógica, substitua o exemplo por seu esquema
  definition = <<DEFINITION
{
  "$schema": "https://schema.management.azure.com/schemas/2015-08-01/logicAppDefinition.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "workflowTrigger": {
      "type": "string",
      "defaultValue": "Manual"
    }
  },
  "actions": [
    {
      "actions": [
        {
          "type": "Http",
          "inputs": {
            "method": "GET",
            "uri": "https://example.com/api/endpoint"
          }
        }
      ],
      "type": "Control",
      "inputs": {
        "conditions": [
          {
            "equals": [
              "@parameters('workflowTrigger')",
              "Manual"
            ]
          }
        ]
      }
    }
  ],
  "outputs": {}
}
DEFINITION
}

# Crie um plano de serviço do aplicativo de lógica
resource "azurerm_logic_app_plan" "example" {
  name                 = "example-logic-app-plan"
  location             = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku {
    name = "Free"
  }
}

# Vincule o aplicativo de lógica ao plano de serviço
resource "azurerm_logic_app_plan_app" "example" {
  name                 = "example-logic-app"
  logic_app_id        = azurerm_logic_app.example.id
  resource_group_name = azurerm_resource_group.example.name
  logic_app_plan_id   = azurerm_logic_app_plan.example.id
}

    