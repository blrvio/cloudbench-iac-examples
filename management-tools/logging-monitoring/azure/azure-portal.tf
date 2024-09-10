
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Ensure the provider is up-to-date
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "westus2"
}

# Create a storage account
resource "azurerm_storage_account" "example" {
  name                     = "example-storage-account"
  resource_group_name      = azurerm_resource_group.example.name
  location                  = azurerm_resource_group.example.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
  # ... other storage account settings
}

# Create a virtual network
resource "azurerm_virtual_network" "example" {
  name                = "example-virtual-network"
  resource_group_name = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# Create a subnet
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a virtual machine
resource "azurerm_linux_virtual_machine" "example" {
  name                  = "example-vm"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = "Standard_B2s"
  admin_username        = "azureuser"
  admin_password        = "P@$$wOrd"
  network_interface_ids = [azurerm_network_interface.example.id]
  # ... other virtual machine settings
}

# Create a network interface
resource "azurerm_network_interface" "example" {
  name                 = "example-nic"
  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  subnet_id            = azurerm_subnet.example.id
  # ... other network interface settings
}

  