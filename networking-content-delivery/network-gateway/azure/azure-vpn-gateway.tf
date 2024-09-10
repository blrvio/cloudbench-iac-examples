
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all Azure features
}

# Create a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = "example-resources"
  location            = "westus"
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name = "example-resources"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes    = ["10.0.1.0/24"]
}

# Create a VPN Gateway
resource "azurerm_vpn_gateway" "example" {
  name                = "example-vpn-gateway"
  resource_group_name = "example-resources"
  location            = "westus"
  virtual_network_name = azurerm_virtual_network.example.name
  vpn_type            = "RouteBased"
  sku                  = "Standard"
  # You'll need to define a public IP address for the VPN Gateway
  # Refer to the Azure documentation for configuring a Public IP address
  # public_ip_address_id = azurerm_public_ip.example.id
}

  