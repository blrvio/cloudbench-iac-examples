
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create a Marketplace Image
resource "azurerm_marketplace_image" "example" {
  name                 = "example-marketplace-image"
  location              = "westus2"
  resource_group_name  = azurerm_resource_group.example.name
  plan {
    name = "Standard"
  }
  publisher           = "Microsoft"
  offer               = "SQLServer2019-Standard"
  sku                 = "SQLServer2019-Standard"
  version              = "latest"
}

# Create a Virtual Machine from Marketplace Image
resource "azurerm_linux_virtual_machine" "example" {
  name                 = "example-vm"
  location              = "westus2"
  resource_group_name  = azurerm_resource_group.example.name
  size                 = "Standard_B2s"
  network_interface_ids = [azurerm_network_interface.example.id]
  source_image_reference {
    publisher = "Microsoft"
    offer     = "SQLServer2019-Standard"
    sku       = "SQLServer2019-Standard"
    version    = "latest"
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

# Create a Network Interface
resource "azurerm_network_interface" "example" {
  name                 = "example-nic"
  location              = "westus2"
  resource_group_name  = azurerm_resource_group.example.name
  subnet_id            = azurerm_subnet.example.id
}

# Create a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                 = "example-vnet"
  location              = "westus2"
  resource_group_name  = azurerm_resource_group.example.name
  address_space        = ["10.0.0.0/16"]
}

# Create a Subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

  