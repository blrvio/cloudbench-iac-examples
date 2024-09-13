
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Para usar as últimas funcionalidades
}

# Crie um circuito Express Route
resource "azurerm_express_route_circuit" "example" {
  name                = "example-circuit"
  location            = "West Europe"
  resource_group_name = "example-resources"
  bandwidth_in_mbps   = 100
  service_provider    = "Equinix"
  peering_location    = "London"
}

# Crie um peering de roteamento
resource "azurerm_express_route_circuit_peering" "example" {
  name                = "example-peering"
  express_route_circuit_id = azurerm_express_route_circuit.example.id
  peer_type             = "AzurePrivatePeering"
  microsoft_peering_config {
    advertised_public_prefixes = ["10.0.0.0/16"]
  }
  routing_policy {
    as_path_segments = ["10.0.0.0/16"]
  }
}

# Crie um circuito virtual
resource "azurerm_express_route_circuit_virtual_network_peering" "example" {
  name                = "example-peering"
  express_route_circuit_id = azurerm_express_route_circuit.example.id
  virtual_network_id = azurerm_virtual_network.example.id
  route_filter_id    = azurerm_route_filter.example.id
}

# Crie uma rota na tabela de roteamento
resource "azurerm_route_table" "example" {
  name                = "example-route-table"
  location            = "West Europe"
  resource_group_name = "example-resources"
}

# Crie uma rota na tabela de roteamento
resource "azurerm_route_table_route" "example" {
  name                = "example-route"
  route_table_id      = azurerm_route_table.example.id
  address_prefix      = "10.0.0.0/16"
  next_hop_type       = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_virtual_network_gateway.example.ip_address
}

# Crie um gateway de rede virtual
resource "azurerm_virtual_network_gateway" "example" {
  location                 = "West Europe"
  name                     = "example-gateway"
  resource_group_name    = "example-resources"
  virtual_network_id      = azurerm_virtual_network.example.id
  location                 = "West Europe"
  type                     = "ExpressRoute"
  vpn_type                 = "RouteBased"
  sku                     = "Standard"
  active_active             = true
  express_route_circuit_id = azurerm_express_route_circuit.example.id
}

# Crie uma rede virtual
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = "West Europe"
  resource_group_name = "example-resources"
  address_space       = ["10.0.0.0/16"]
}

# Crie um filtro de rota
resource "azurerm_route_filter" "example" {
  name                = "example-route-filter"
  location            = "West Europe"
  resource_group_name = "example-resources"
}

# Crie uma regra de roteamento
resource "azurerm_route_filter_rule" "example" {
  name                = "example-rule"
  route_filter_id    = azurerm_route_filter.example.id
  access             = "Allow"
  route_filter_rule_type = "Community"
  community          = "100:1"
  address_prefix      = "10.0.0.0/16"
}

    