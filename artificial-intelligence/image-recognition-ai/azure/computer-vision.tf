
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Computer Vision resource
resource "azurerm_cognitive_services_account" "main" {
  name                = "my-computer-vision-account"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  kind                = "ComputerVision"
  sku {
    name = "S0"
  }
}

# Create an access key for the Computer Vision resource
resource "azurerm_cognitive_services_account_key" "main" {
  name                = "primary"
  cognitive_services_account_name = azurerm_cognitive_services_account.main.name
  resource_group_name = azurerm_cognitive_services_account.main.resource_group_name
}

# Output the Computer Vision endpoint and key
output "endpoint" {
  value = azurerm_cognitive_services_account.main.endpoint
}

output "key" {
  value = azurerm_cognitive_services_account_key.main.value
}

  