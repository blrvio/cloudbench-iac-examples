
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westus2"
}

# Create a DNS zone
resource "azurerm_dns_zone" "example" {
  name                = "example.com"
  resource_group_name = azurerm_resource_group.example.name
}

# Create a DNS record set
resource "azurerm_dns_record_set" "example" {
  name                = "www"
  resource_group_name = azurerm_resource_group.example.name
  zone_name          = azurerm_dns_zone.example.name
  type                = "A"
  ttl                 = 3600
  records              = ["10.0.0.4"]
}

  