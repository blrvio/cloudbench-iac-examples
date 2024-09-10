
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "westus2"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]

  # Create Subnets
  subnet {
    name           = "example-subnet"
    address_prefixes = ["10.0.1.0/24"]
  }
}

# Create a Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Allow inbound traffic from the internet on port 80
  security_rule {
    name                       = "allow-http"
    priority                    = 100
    direction                   = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix       = "Internet"
    destination_address_prefix = "*"
  }
}

# Associate the Network Security Group to the Subnet
resource "azurerm_subnet_network_security_group_association" "example" {
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  subnet_name           = azurerm_virtual_network.example.subnet.0.name
  network_security_group_id = azurerm_network_security_group.example.id
}

  