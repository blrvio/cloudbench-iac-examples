
    # Configure the Azure Provider
provider "azurerm" {
  features {}  
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create a App Center Distribution Group
resource "azurerm_appcenter_distribution_group" "example" {
  name     = "example-dist-group"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Add additional optional attributes
}

# Create a App Center Test Configuration
resource "azurerm_appcenter_test_configuration" "example" {
  name     = "example-test-configuration"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Add additional optional attributes
}

  