
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable Azure features
}

# Define a Virtual Machine Scale Set
resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                       = "example-vmss"
  location                   = "westus2"
  resource_group_name        = "example-resources"
  sku                        = "Standard_A2_v2"
  # Use a pre-defined disk image
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version    = "Latest"
  }
  # Define the network settings for the VMSS
  network_interface {
    name = "nic"
    ip_configuration {
      name = "ipconfig"
      # Subnet defined in the existing virtual network
      subnet_id = azurerm_subnet.example.id
    }
  }

  # Configure the VMSS scaling settings
  # This example will scale between 1 and 3 instances
  # The default number of instances is 1
  capacity {
    min = 1
    max = 3
  }
}

# Define a virtual network for the VMSS
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location             = "westus2"
  resource_group_name = "example-resources"
  address_space       = ["10.0.0.0/16"]
}

# Define a subnet for the VMSS within the virtual network
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name = "example-resources"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Define a network security group for the VMSS
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location             = "westus2"
  resource_group_name = "example-resources"
  # Define the inbound security rules for the VMSS
  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range         = "*"
    destination_port_range     = "22"
    source_address_prefix       = "*"
    destination_address_prefix = "*"
  }
}

# Define a network interface for the VMSS
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location             = "westus2"
  resource_group_name = "example-resources"
  # Define the IP configuration for the network interface
  ip_configuration {
    name = "ipconfig"
    # Subnet defined in the existing virtual network
    subnet_id = azurerm_subnet.example.id
    # Network security group for the network interface
    security_group_id = azurerm_network_security_group.example.id
  }
}

  