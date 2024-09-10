
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Private Cloud
resource "azurerm_privatecloud" "main" {
  name                = "my-private-cloud"
  location            = "eastus2"
  resource_group_name = "my-resource-group"
  # Specify the desired capacity for the cluster.
  size                = 1
  # Use the default values for the rest of the configuration
}

# Create a Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "my-virtual-network"
  location            = "eastus2"
  resource_group_name = "my-resource-group"
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "main" {
  name                 = "my-subnet"
  resource_group_name  = "my-resource-group"
  virtual_network_name = "my-virtual-network"
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Virtual Machine
resource "azurerm_linux_virtual_machine" "main" {
  name                = "my-vm"
  location            = "eastus2"
  resource_group_name = "my-resource-group"
  size                = "Standard_B2s"
  # Use the default values for the rest of the configuration
}

# Associate the VM to the Subnet
resource "azurerm_network_interface" "main" {
  name                = "my-nic"
  location            = "eastus2"
  resource_group_name = "my-resource-group"
  # Use the default values for the rest of the configuration
}

  