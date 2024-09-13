
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Use recursos de preview
}

# Crie um perfil de CDN
resource "azurerm_cdn_profile" "example" {
  name     = "my-cdn-profile"
  resource_group_name = "my-resource-group"
  location = "westus"
  sku {
    name  = "Standard_Verizon"
    tier = "Standard"
  }
  tags = {
    Environment = "Production"
  }
}

# Crie um endpoint de CDN
resource "azurerm_cdn_endpoint" "example" {
  name                 = "my-cdn-endpoint"
  profile_name         = azurerm_cdn_profile.example.name
  resource_group_name = azurerm_cdn_profile.example.resource_group_name
  origin {
    name = "my-origin"
    host_name = "www.example.com"
  }
}


    