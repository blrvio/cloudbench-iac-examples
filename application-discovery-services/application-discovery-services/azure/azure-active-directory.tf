
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Active Directory Application
resource "azurerm_ad_application" "example" {
  name     = "example-app"
  display_name  = "Example Application"
  # Optional: You can configure more options based on your needs, e.g., reply_urls, etc.
}

# Create an Azure Active Directory Service Principal
resource "azurerm_ad_service_principal" "example" {
  application_id = azurerm_ad_application.example.application_id
}

  