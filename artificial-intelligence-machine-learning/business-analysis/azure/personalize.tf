
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create a Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "westus2"
}

# Create a Personalizer service
resource "azurerm_cognitive_services_account" "personalizer" {
  name                = "my-personalizer"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "personalizer"
  sku {
    name     = "F0"
    tier     = "Free"
    capacity = 1
  }
}

# Create a Personalizer Deployment
resource "azurerm_personalizer_deployment" "main" {
  name                = "my-deployment"
  cognitive_services_account_id = azurerm_cognitive_services_account.personalizer.id
  resource_group_name      = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
}

# Create a Personalizer Ranker
resource "azurerm_personalizer_ranker" "main" {
  name                = "my-ranker"
  cognitive_services_account_id = azurerm_cognitive_services_account.personalizer.id
  resource_group_name      = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
}

  