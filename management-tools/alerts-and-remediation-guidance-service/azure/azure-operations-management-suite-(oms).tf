
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Habilita recursos adicionais
}

# Crie um workspace do Log Analytics
resource "azurerm_log_analytics_workspace" "example" {
  name                = "example-workspace"
  location            = "westeurope"
  resource_group_name = "example-resources"
  retention_in_days  = 30
}

# Crie uma máquina virtual Linux
resource "azurerm_linux_virtual_machine" "example" {
  name                 = "example-vm"
  location             = "westeurope"
  resource_group_name  = "example-resources"
  size                 = "Standard_B2s"
  admin_username       = "azureuser"
  admin_password       = "password123" # Substitua por uma senha segura
  network_interface_ids = [azurerm_network_interface.example.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

# Crie uma interface de rede
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = "westeurope"
  resource_group_name = "example-resources"
  network_security_group_id = azurerm_network_security_group.example.id
  subnet_id         = azurerm_subnet.example.id
}

# Crie um grupo de segurança de rede
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = "westeurope"
  resource_group_name = "example-resources"
}

# Crie uma sub-rede
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = "example-resources"
  virtual_network_name = "example-vnet"
  address_prefixes     = ["10.0.0.0/24"]
}

# Crie uma rede virtual
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = "westeurope"
  resource_group_name = "example-resources"
  address_space       = ["10.0.0.0/16"]
}
    