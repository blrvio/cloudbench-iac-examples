
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # para habilitar recursos mais recentes
}

# Crie um Gateway VPN
resource "azurerm_vpn_gateway" "example" {
  name                = "example-vpn-gw"
  location            = "West Europe"
  resource_group_name = "example-resources"
  vpn_type           = "RouteBased"
  sku                 = "Standard"
}

# Crie uma VPN Connection
resource "azurerm_vpn_connection" "example" {
  name                 = "example-vpn-connection"
  resource_group_name  = "example-resources"
  vpn_gateway_name    = azurerm_vpn_gateway.example.name
  local_network_gateway_id = azurerm_local_network_gateway.example.id
  use_policy_based_traffic_selectors = false
  vpn_type = "RouteBased"
}

# Crie um Local Network Gateway
resource "azurerm_local_network_gateway" "example" {
  name                = "example-local-network-gateway"
  resource_group_name = "example-resources"
  location            = "West Europe"
  address_space       = ["10.0.1.0/24"]
  bgp_asn             = 65000 # Número ASN do seu próprio gateway
}

# Crie um Virtual Network Gateway Connection
resource "azurerm_virtual_network_gateway_connection" "example" {
  name                 = "example-vnet-gateway-connection"
  resource_group_name  = "example-resources"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.example.id
  local_network_gateway_id   = azurerm_local_network_gateway.example.id
  connection_type = "IPsec"
  use_policy_based_traffic_selectors = false
}

# Crie um Virtual Network Gateway
resource "azurerm_virtual_network_gateway" "example" {
  name                = "example-vnet-gw"
  location            = "West Europe"
  resource_group_name = "example-resources"
  vpn_type           = "RouteBased"
  sku                 = "Standard"
  virtual_network_id = azurerm_virtual_network.example.id
}

# Crie um Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = "West Europe"
  resource_group_name = "example-resources"
  address_space       = ["10.0.0.0/16"]
}

    