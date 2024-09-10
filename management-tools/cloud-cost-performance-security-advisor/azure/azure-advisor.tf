
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a resource group for your Azure Advisor
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "westus"
}

# Create an Azure Advisor configuration
resource "azurerm_advisor_configuration" "example" {
  name                = "example-advisor-config"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

  