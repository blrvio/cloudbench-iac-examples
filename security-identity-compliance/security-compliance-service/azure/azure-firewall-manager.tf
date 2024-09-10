
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Use the latest version of the provider
}

# Create a Firewall Policy
resource "azurerm_firewall_policy" "example" {
  name                = "example-firewall-policy"
  location            = "westus2"
  resource_group_name = "example-resources"

  # Define the firewall policy rules
  firewall_policy_rule_collection_group {
    name             = "example-collection"
    priority         = 100
    rule_collection {
      name   = "example-rule-collection"
      action = "Allow"

      rule {
        name           = "allow-ssh"
        protocol       = "Tcp"
        source_ports    = ["22"]
        destination_ports = ["22"]
      }

      rule {
        name           = "allow-http"
        protocol       = "Tcp"
        source_ports    = ["80"]
        destination_ports = ["80"]
      }

      rule {
        name           = "allow-https"
        protocol       = "Tcp"
        source_ports    = ["443"]
        destination_ports = ["443"]
      }
    }
  }
}

# Create a Firewall Manager for a Virtual Network
resource "azurerm_firewall_manager_network" "example" {
  name                = "example-firewall-manager"
  resource_group_name = "example-resources"
  location            = "westus2"
  virtual_network_id  = azurerm_virtual_network.example.id
  firewall_policy_id = azurerm_firewall_policy.example.id
}

# Create a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = "example-resources"
  location            = "westus2"
  address_space       = ["10.0.0.0/16"]
}

  