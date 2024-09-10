
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Security Center workspace
resource "azurerm_security_center_workspace" "main" {
  name                = "my-security-center-workspace"
  resource_group_name = "my-resource-group"
  location            = "westus2"
  # Optional settings
  # Enable auto provisioning for the security center workspace
  auto_provisioning  = false
}

# Create a security contact
resource "azurerm_security_center_contact" "main" {
  workspace_name      = azurerm_security_center_workspace.main.name
  resource_group_name = azurerm_security_center_workspace.main.resource_group_name
  email               = "example@example.com"
  phone               = "1234567890"
  name                = "Security Contact"
}

# Create a security policy
resource "azurerm_security_center_policy" "main" {
  workspace_name      = azurerm_security_center_workspace.main.name
  resource_group_name = azurerm_security_center_workspace.main.resource_group_name
  # Use the built-in 'Standard' policy
  policy_type = "Standard"
  # Customize the policy settings
  # Example: Enable data collection for all subscriptions in the workspace
  settings {
    data_collection {
      enabled = true
    }
  }
}

  