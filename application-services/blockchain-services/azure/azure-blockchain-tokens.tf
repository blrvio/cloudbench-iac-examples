
    # Configure the Azure provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create a Blockchain Token network
resource "azurerm_blockchain_token_network" "example" {
  location                   = "westus2"
  name                      = "my-blockchain-token-network"
  resource_group_name     = "my-resource-group"
  token_network_version  = "v1"
  token_network_protocol = "ethereum"
}

# Create a Blockchain Token network service
resource "azurerm_blockchain_token_service" "example" {
  location                      = "westus2"
  name                         = "my-blockchain-token-service"
  resource_group_name        = "my-resource-group"
  token_network_network_name = azurerm_blockchain_token_network.example.name
  token_network_service_type = "default"
}

# Create a Blockchain Token network network
resource "azurerm_blockchain_token_network_network" "example" {
  location                      = "westus2"
  name                         = "my-blockchain-token-network-network"
  resource_group_name        = "my-resource-group"
  token_network_service_name = azurerm_blockchain_token_service.example.name
}

  