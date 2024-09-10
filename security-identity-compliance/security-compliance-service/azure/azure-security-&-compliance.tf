
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all Azure features
}

# Create a Security Center Contact
resource "azurerm_security_center_contact" "example" {
  name    = "example-security-center-contact"
  email   = "example@example.com"
  phone   = "1234567890"
  location = "westus2"
  # Specify the subscription ID for the resource
  subscription_id = "00000000-0000-0000-0000-000000000000"
}

# Create a Security Center Subscription
resource "azurerm_security_center_subscription" "example" {
  workspace_name = "example-workspace"
  location       = "westus2"
  # Specify the subscription ID for the resource
  subscription_id = "00000000-0000-0000-0000-000000000000"
}

# Create a Security Center Workspace
resource "azurerm_security_center_workspace" "example" {
  location = "westus2"
  # Specify the subscription ID for the resource
  subscription_id = "00000000-0000-0000-0000-000000000000"
  workspace_id     = "example-workspace"
  # Optional - Specify the resource group where the Security Center workspace is created
  resource_group_name = "example-resource-group"
}
  