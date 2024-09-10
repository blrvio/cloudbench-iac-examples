
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure CDN Profile
resource "azurerm_cdn_profile" "example" {
  name                = "example-cdn-profile"
  resource_group_name = "example-resource-group"
  location            = "westus2"
  sku {
    name = "Standard_Verizon"
  }
}

# Create an Azure CDN Endpoint
resource "azurerm_cdn_endpoint" "example" {
  name                = "example-cdn-endpoint"
  profile_name         = azurerm_cdn_profile.example.name
  resource_group_name = azurerm_cdn_profile.example.resource_group_name
  origin {
    hostname = "example.com"
  }
}

# Create an Azure CDN Origin
resource "azurerm_cdn_origin" "example" {
  endpoint_name      = azurerm_cdn_endpoint.example.name
  profile_name        = azurerm_cdn_profile.example.name
  resource_group_name = azurerm_cdn_profile.example.resource_group_name
  name                = "example-origin"
  hostname            = "example.com"
  http_port           = 80
  https_port          = 443
}

  