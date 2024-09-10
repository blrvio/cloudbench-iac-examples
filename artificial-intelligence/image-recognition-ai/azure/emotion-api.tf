
    # Configure the Azure Provider
provider "azurerm" {
  features {} 
}

# Create a Cognitive Services account
resource "azurerm_cognitive_services_account" "main" {
  name                = "my-emotion-api-account"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  kind                = "Emotion"
  sku {
    name = "S0"
  }
  # You can choose other SKUs depending on your needs
  # See https://azure.microsoft.com/pricing/details/cognitive-services/emotion/
}

# Get the API key for the Cognitive Services account
output "api_key" {
  value = azurerm_cognitive_services_account.main.primary_key
}

# You can use the API key to call the Emotion API
# See https://westus2.api.cognitive.microsoft.com/docs/services/56f222a71984550e40cb87f7/operations/56f222a71984550e40cb87fb for more information

  