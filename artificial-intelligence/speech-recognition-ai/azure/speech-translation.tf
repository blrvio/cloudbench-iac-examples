
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all Azure features
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "my-speech-translation-rg"
  location = "westus2"
}

# Create a Speech Service
resource "azurerm_cognitive_services_account" "main" {
  name     = "my-speech-translation-account"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind    = "Speech"
  sku {
    name  = "S0"
    tier = "Free"
  }
  # Suppress the long string for the key
  # api_key = "YOUR_API_KEY_HERE"
}

# Create an API endpoint
resource "azurerm_cognitive_services_account_endpoint" "main" {
  account_name       = azurerm_cognitive_services_account.main.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name                = "my-endpoint"
}

  