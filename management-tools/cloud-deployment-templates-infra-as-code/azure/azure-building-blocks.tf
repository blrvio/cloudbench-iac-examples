
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable AzureRM features
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "westus2"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-virtual-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  # Define the inbound and outbound rules
  security_rule {
    name                       = "allow_ssh"
    priority                    = 100
    direction                   = "Inbound"
    access                     = "Allow"
    protocol                    = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix       = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow_http"
    priority                    = 101
    direction                   = "Inbound"
    access                     = "Allow"
    protocol                    = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix       = "*"
    destination_address_prefix = "*"
  }
}

# Create a Public IP Address
resource "azurerm_public_ip_address" "example" {
  name                = "example-pip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method = "Dynamic"
}

# Create a Network Interface
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  network_security_group_id = azurerm_network_security_group.example.id
  ip_configuration {
    name                              = "ipconfig1"
    subnet_id                          = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id            = azurerm_public_ip_address.example.id
  }
}

# Create a Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                = "Standard_B2s"
  network_interface_ids = [azurerm_network_interface.example.id]
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
  # Specify the administrator username and password
  admin_username = "azureuser"
  admin_password = "P@sswOrd1"
}

  