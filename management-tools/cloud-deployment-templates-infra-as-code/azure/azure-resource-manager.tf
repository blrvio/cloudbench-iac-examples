
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Permite utilizar recursos recentes
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie um armazenamento de blobs
resource "azurerm_storage_account" "example" {
  name                     = "example-storage"
  resource_group_name     = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Crie uma máquina virtual
resource "azurerm_linux_virtual_machine" "example" {
  name                  = "example-vm"
  resource_group_name  = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = "Standard_B2s"
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

# Crie uma interface de rede
resource "azurerm_network_interface" "example" {
  name                  = "example-nic"
  resource_group_name  = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  network_security_group_id = azurerm_network_security_group.example.id
  location              = azurerm_resource_group.example.location
  subnet_id            = azurerm_subnet.example.id
}

# Crie um grupo de segurança de rede
resource "azurerm_network_security_group" "example" {
  name                  = "example-nsg"
  resource_group_name  = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
}

# Crie uma rede virtual
resource "azurerm_virtual_network" "example" {
  name                  = "example-vnet"
  resource_group_name  = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  address_space         = ["10.0.0.0/16"]
}

# Crie uma sub-rede
resource "azurerm_subnet" "example" {
  name                  = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

    