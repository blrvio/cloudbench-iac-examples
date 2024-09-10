
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes    = ["10.0.1.0/24"]
}

# Create a Virtual Machine
resource "azurerm_linux_virtual_machine" "example" {
  name                 = "example-vm"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                 = "Standard_B2s"
  network_interface_ids = [azurerm_network_interface.example.id]
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "Latest"
  }
}

# Create a Network Interface
resource "azurerm_network_interface" "example" {
  name                 = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  network_security_group_id = azurerm_network_security_group.example.id
  ip_configuration {
    name                          = "example-ipconfig"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a Network Security Group
resource "azurerm_network_security_group" "example" {
  name                 = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Create a Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "example-storage"
  resource_group_name      = azurerm_resource_group.example.name
  location                  = azurerm_resource_group.example.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
}

# Create a Storage Container
resource "azurerm_storage_container" "example" {
  name                 = "example-container"
  storage_account_name = azurerm_storage_account.example.name
  resource_group_name = azurerm_resource_group.example.name
  container_access_type = "blob"
}

  