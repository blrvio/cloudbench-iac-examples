
      # Configure the Azure Provider
provider "azurerm" {
  features {} # This is needed for the Azure Security Center features
}

# Enable Azure Security Center Standard for a Subscription
resource "azurerm_security_center_subscription_pricing" "standard" {
  subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Substitute with your Subscription ID
  pricing_tier   = "Standard"
}

# Create a Security Contact for the Subscription
resource "azurerm_security_center_contact" "contact" {
  subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Substitute with your Subscription ID
  email           = "security@example.com" # Substitute with your security contact email
  phone           = "1234567890"
  contact_type    = "Primary"
}

# Create an Azure Policy for resource tagging
resource "azurerm_policy_definition" "resource_tagging" {
  name         = "tag-resources"
  policy_type  = "BuiltIn"
  display_name = "Resource Tagging"
  description  = "Enforces tagging of resources"
  policy_rule  = <<EOF
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Compute/virtualMachines"
      },
      {
        "field": "tags['Environment']",
        "not": {
          "exists": true
        }
      }
    ]
  },
  "then": {
    "effect": "audit"
  }
}
EOF
}

# Assign the Azure Policy to a Resource Group
resource "azurerm_policy_assignment" "resource_group_assignment" {
  name            = "tag-resources-assignment"
  policy_definition_id = azurerm_policy_definition.resource_tagging.id
  scope          = "resourceGroup(rg-xxxxxxxx)" # Substitute with your Resource Group Name
}

    