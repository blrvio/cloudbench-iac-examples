
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Garante a compatibilidade com recursos mais recentes
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe"
}

# Crie uma zona DNS
resource "azurerm_dns_zone" "example" {
  name                = "example.com"
  resource_group_name = azurerm_resource_group.example.name
}

# Crie um registro A
resource "azurerm_dns_record_set" "a" {
  name                = "www"
  resource_group_name = azurerm_resource_group.example.name
  zone_name           = azurerm_dns_zone.example.name
  type                = "A"
  ttl                 = 3600

  records = ["10.0.0.4"]
}
    