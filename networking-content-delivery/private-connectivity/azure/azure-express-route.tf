
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Define the Express Route Circuit
resource "azurerm_express_route_circuit" "example" {
  name                = "example-express-route-circuit"
  location            = "westus"
  resource_group_name = "example-resource-group"
  service_provider_name = "ExampleServiceProvder"
  bandwidth_in_mbps     = 100
}

# Define the Express Route Connection
resource "azurerm_express_route_connection" "example" {
  name                = "example-express-route-connection"
  resource_group_name = "example-resource-group"
  express_route_circuit_name = azurerm_express_route_circuit.example.name
  bandwidth_in_mbps     = 100
  routing_config {
    advertised_public_prefixes = ["10.0.0.0/16"]
  }
}

# Define the Express Route Peering
resource "azurerm_express_route_peering" "example" {
  name                = "example-express-route-peering"
  resource_group_name = "example-resource-group"
  express_route_circuit_name = azurerm_express_route_circuit.example.name
  peer_type           = "microsoft_peering"
}

# Define the Express Route Gateway
resource "azurerm_express_route_gateway" "example" {
  name                = "example-express-route-gateway"
  resource_group_name = "example-resource-group"
  location            = "westus"
  virtual_network_name = "example-virtual-network"
}

# Define the Express Route Gateway Connection
resource "azurerm_express_route_gateway_connection" "example" {
  name                = "example-express-route-gateway-connection"
  resource_group_name = "example-resource-group"
  express_route_gateway_name = azurerm_express_route_gateway.example.name
  express_route_circuit_peering_id = azurerm_express_route_peering.example.id
  routing_config {
    advertised_public_prefixes = ["10.0.0.0/16"]
  }
}

  