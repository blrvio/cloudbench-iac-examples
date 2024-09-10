
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Use this to enable features not available in the current version
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "eastus2"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet
resource "azurerm_subnet" "subnet" {
  name                 = "my-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes      = ["10.0.1.0/24"]
}

# Create a network security group
resource "azurerm_network_security_group" "nsg" {
  name                = "my-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a network security group rule
resource "azurerm_network_security_group_rule" "nsg_rule" {
  name                = "allow-ssh"
  priority            = 100
  direction           = "Inbound"
  access              = "Allow"
  protocol            = "Tcp"
  source_port_range    = "*"
  destination_port_range = "22"
  source_address_prefix = "*"
  destination_address_prefix = "*
  resource_group_name = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Create a virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "my-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_A2_v2"
  # Choose a suitable Linux distribution
  # See the documentation for more available options
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  network_interface_ids = [azurerm_network_interface.nic.id]
  # Create a password for the virtual machine
  # You can also use a key pair for authentication
  admin_password = "MyStrongP@ssw0rd"
  # Attach the network security group
  network_security_group_ids = [azurerm_network_security_group.nsg.id]
  # Assign the virtual machine to the subnet
  subnet_id = azurerm_subnet.subnet.id
}

# Create a network interface
resource "azurerm_network_interface" "nic" {
  name                = "my-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  # Configure the network interface for the virtual network and subnet
  network_security_group_id = azurerm_network_security_group.nsg.id
  ip_configuration {
    name = "my-ip-config"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

  