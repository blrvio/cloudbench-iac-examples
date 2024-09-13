
      # Configure o provedor do Azure
provider "azurerm" {
  features {}
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "logic_app_rg" {
  name     = "logic-app-rg"
  location = "westus2"
}

# Crie um aplicativo lógico
resource "azurerm_logic_app" "logic_app" {
  name                = "logic-app"
  location            = azurerm_resource_group.logic_app_rg.location
  resource_group_name = azurerm_resource_group.logic_app_rg.name

  location  = "westus2"
  storage_account_name = "storage-account"
}

# Crie uma definição de fluxo de trabalho
resource "azurerm_logic_app_workflow" "workflow" {
  name               = "workflow"
  logic_app_name     = azurerm_logic_app.logic_app.name
  resource_group_name = azurerm_resource_group.logic_app_rg.name

  location  = "westus2"
  definition = <<EOF
{
  "$schema": "https://schema.management.azure.com/schemas/2015-08-01/logic-app-definition.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "actions": {
    "Http": {
      "type": "Http",
      "inputs": {
        "method": "GET",
        "uri": "https://example.com/api"
      },
      "runAfter": {}
    }
  }
}
EOF
}

    