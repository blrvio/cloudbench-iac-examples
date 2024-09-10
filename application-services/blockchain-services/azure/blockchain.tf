
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create an Azure Blockchain Service
resource "azurerm_blockchain_service" "example" {
  name                 = "example-blockchain-service"
  location             = "westus2"
  resource_group_name = "example-resources"
  # Configure the Blockchain Service
  blockchain_service_network_acls {
    default_action = "allow"
    rules {
      # Allow traffic from specific IP addresses
      action          = "allow"
      description     = "Allow traffic from specific IP addresses"
      direction       = "inbound"
      ip_address_range = "10.0.0.0/16"
      protocol        = "tcp"
    }
  }
}

# Create a Blockchain Network
resource "azurerm_blockchain_network" "example" {
  name                 = "example-blockchain-network"
  location             = "westus2"
  resource_group_name = "example-resources"
  blockchain_service_id = azurerm_blockchain_service.example.id
}

# Create a Consortium
resource "azurerm_blockchain_consortium" "example" {
  name                 = "example-consortium"
  location             = "westus2"
  resource_group_name = "example-resources"
  blockchain_network_id = azurerm_blockchain_network.example.id
  members {
    member_name     = "example-member"
    member_type     = "organization"
    invitation_code = "example-invitation-code"
    # Configure the member's role
    member_role = "operator"
  }
}

  