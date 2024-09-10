
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create an Azure Network Security Group
resource "azurerm_network_security_group" "main" {
  name                = "example-nsg"
  location            = "westus2"
  resource_group_name = "example-resources"
}

# Create a DDoS Protection Plan
resource "azurerm_ddos_protection_plan" "main" {
  name                = "example-ddos-plan"
  location            = "westus2"
  resource_group_name = "example-resources"
  # Set the virtual network to protect
  virtual_network_ids = [azurerm_virtual_network.main.id]
}

# Create a Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "example-vnet"
  location            = "westus2"
  resource_group_name = "example-resources"
  address_space       = ["10.0.0.0/16"]
  # Set the subnet for the DDoS Protection Plan
  subnet {
    name                 = "default"
    address_prefixes    = ["10.0.1.0/24"]
    # Configure the subnet to use the DDoS Protection Plan
    ddos_protection_plan_id = azurerm_ddos_protection_plan.main.id
  }
}

  