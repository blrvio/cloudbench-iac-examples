
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features for compatibility
}

# Define the Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Define the Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# Define the Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Define the Network Security Group
resource "azurerm_network_security_group" "example" {
  name                 = "example-nsg"
  resource_group_name  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

# Define the Network Security Group Rule
resource "azurerm_network_security_group_rule" "example" {
  name                 = "example-nsg-rule"
  resource_group_name  = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
  priority             = 100
  direction            = "Inbound"
  access               = "Allow"
  protocol            = "Tcp"
  source_port_range     = "*"
  destination_port_range = "22"
  source_address_prefix  = "*"
  destination_address_prefix = "*"
}

# Define the Virtual Machine
resource "azurerm_linux_virtual_machine" "example" {
  name                          = "example-vm"
  resource_group_name             = azurerm_resource_group.example.name
  location                       = azurerm_resource_group.example.location
  size                          = "Standard_B2s"
  network_interface_ids           = [azurerm_network_interface.example.id]
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_username = "azureuser"
  admin_password = "P@$$wOrd"
  # Assign a static IP address
  # network_interface_ids = [azurerm_network_interface.example.id]
  # network_interface {
  #   name = "example-nic"
  #   resource_group_name = azurerm_resource_group.example.name
  #   location = azurerm_resource_group.example.location
  #   ip_configuration {
  #     name = "example-ip"
  #     subnet_id = azurerm_subnet.example.id
  #     # Assign a static IP address
  #     private_ip_address_allocation = "Static"
  #     private_ip_address = "10.0.1.4"
  #   }
  # }
}

# Define the Network Interface
resource "azurerm_network_interface" "example" {
  name                 = "example-nic"
  resource_group_name  = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  network_security_group_id = azurerm_network_security_group.example.id
  ip_configuration {
    name = "example-ip"
    subnet_id = azurerm_subnet.example.id
    # Assign a static IP address
    # private_ip_address_allocation = "Static"
    # private_ip_address = "10.0.1.4"
  }
}

  