
    # Configure the Azure Provider
provider "azurerm" {
  features {} 
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "westus2"
}

# Create a Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "example-storage-account"
  resource_group_name       = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Network Security Group
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

# Create a Network Security Group Rule
resource "azurerm_network_security_group_rule" "example" {
  name                 = "example-nsg-rule"
  resource_group_name = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
  priority              = 100
  direction             = "Inbound"
  access                = "Allow"
  protocol             = "Tcp"
  source_port_range     = "*"
  destination_port_range = "80"
  source_address_prefix = "*"
  destination_address_prefix = "*"
}

# Create a Virtual Machine
resource "azurerm_linux_virtual_machine" "example" {
  name                 = "example-vm"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                 = "Standard_A2_v2"
  network_interface_ids = [azurerm_network_interface.example.id]
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

# Create a Network Interface
resource "azurerm_network_interface" "example" {
  name                 = "example-nic"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  # Ensure that the NIC is associated with the subnet and NSG
  subnet_id = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
  # Configure the IP address
  ip_configuration {
    name = "example-ip-config"
    # Use a static IP address
    private_ip_address_allocation = "Static"
  }
}

  