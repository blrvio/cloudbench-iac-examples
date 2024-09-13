
      # Configure o provedor Azure
provider "azurerm" {
  features {}  # Habilita todas as funcionalidades
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie uma máquina virtual
resource "azurerm_linux_virtual_machine" "example" {
  name                 = "example-vm"
  location             = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                 = "Standard_B2s"
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
}

# Crie uma interface de rede
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  network_security_group_id = azurerm_network_security_group.example.id

  ip_configuration {
    name = "ipconfig1"
    subnet_id = azurerm_subnet.example.id
  }
}

# Crie um grupo de segurança de rede
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allow_ssh"
    priority                    = 100
    direction                   = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix       = "*"
    destination_address_prefix = "*"
  }
}

# Crie uma rede virtual
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Crie uma sub-rede
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes      = ["10.0.1.0/24"]
}
    