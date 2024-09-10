
    resource "azurerm_logic_app" "example" {
  name     = "example-logic-app"
  location = "westus2"
  resource_group_name = "example-resources"

  # Suppress large JSON object
  definition = <<EOF
{
  "$schema": "https://schema.management.azure.com/schemas/2019-05-01/logic-app.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "actions": [
    {
      "type": "Microsoft.Logic/workflows/actions/Http",
      "inputs": {
        "method": "GET",
        "uri": "https://www.google.com/search?q=azure+logic+apps"
      },
      "runAfter": {}
    }
  ],
  "outputs": {}
}
EOF
}

  