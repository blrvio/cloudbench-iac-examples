
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Habilita recursos avançados
}

# Define o peering de VNet
resource "azurerm_virtual_network_peering" "peering" {
  name                = "peering"
  virtual_network_name = "vnet1"
  resource_group_name  = "rg1"
  remote_virtual_network_id = azurerm_virtual_network.remote_vnet.id
  allow_forwarded_traffic  = true
  allow_gateway_transit  = false
  use_remote_gateways       = false
}

# Define o VNet remoto
resource "azurerm_virtual_network" "remote_vnet" {
  name                = "vnet2"
  resource_group_name  = "rg2"
  location             = "westus2"
  address_space        = ["10.10.0.0/16"]
}

# Define o VNet local
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  resource_group_name  = "rg1"
  location             = "westus2"
  address_space        = ["10.0.0.0/16"]
}
    