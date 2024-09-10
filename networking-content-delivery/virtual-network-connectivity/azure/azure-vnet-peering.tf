
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "my-vnet"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  address_space       = ["10.0.0.0/16"]
}

# Create a second Virtual Network
resource "azurerm_virtual_network" "second_vnet" {
  name                = "my-second-vnet"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  address_space       = ["10.1.0.0/16"]
}

# Create a VNet Peering
resource "azurerm_virtual_network_peering" "main" {
  name                = "my-vnet-peering"
  resource_group_name = "my-resource-group"
  virtual_network_name = azurerm_virtual_network.main.name
  remote_virtual_network_id = azurerm_virtual_network.second_vnet.id
  allow_forwarded_traffic = true
  allow_gateway_transit   = true
  use_remote_gateways      = true
}

  