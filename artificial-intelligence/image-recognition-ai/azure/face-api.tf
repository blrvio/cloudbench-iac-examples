
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable features for Azure resources
}

# Create a Cognitive Services Account
resource "azurerm_cognitive_services_account" "main" {
  name                = "my-face-api-account"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  kind                = "FaceApi"
  sku {
    name     = "F0"
    tier     = "Free"
    capacity = 1
  }
}

# Create a Face API resource
resource "azurerm_face_api" "main" {
  name                = "my-face-api"
  cognitive_services_account_id = azurerm_cognitive_services_account.main.id
}

# Set environment variables
output "face_api_endpoint" {
  value = azurerm_face_api.main.endpoint
}
output "face_api_key" {
  value = azurerm_cognitive_services_account.main.api_key
}
  