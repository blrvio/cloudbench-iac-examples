
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Define recursos específicos, caso necessário
}

# Habilite o Azure Security Center para sua subscrição
resource "azurerm_security_center" "default" {
  subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Substitua pelo ID da sua subscrição
  location        = "westeurope" # Substitua pela região desejada
  pricing_tier    = "Standard"
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westeurope"
}

# Crie uma máquina virtual
resource "azurerm_linux_virtual_machine" "example" {
  name                 = "example-vm"
  location              = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  size                 = "Standard_B2s"
  admin_username       = "azureuser"
  admin_password       = "P@$$wOrd"
  network_interface_ids = [azurerm_network_interface.example.id]
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
}

# Crie uma interface de rede
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location             = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  network_security_group_id = azurerm_network_security_group.example.id
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Crie um grupo de segurança de rede
resource "azurerm_network_security_group" "example" {
  name     = "example-nsg"
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Crie uma sub-rede
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Crie uma rede virtual
resource "azurerm_virtual_network" "example" {
  name                 = "example-vnet"
  location              = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space        = ["10.0.0.0/16"]
}

    