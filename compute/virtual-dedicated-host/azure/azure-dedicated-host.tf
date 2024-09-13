
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Enable all features
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# Crie um host dedicado
resource "azurerm_dedicated_host_group" "example" {
  name                = "example-host-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  platform_fault_domain_count = 2 # Configure o número de domínios de falhas da plataforma
}

# Crie uma máquina virtual dentro do host dedicado
resource "azurerm_linux_virtual_machine" "example" {
  name                 = "example-vm"
  location             = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                 = "Standard_A2_v2" # Configure o tamanho da máquina virtual
  admin_username       = "azureuser"
  admin_password       = "P@$$wOrd"
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  network_interface_ids = [azurerm_network_interface.example.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  host_group_id = azurerm_dedicated_host_group.example.id
}

# Crie uma interface de rede
resource "azurerm_network_interface" "example" {
  name                 = "example-nic"
  location             = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  network_security_group_id = azurerm_network_security_group.example.id
  private_ip_address_allocation = "Dynamic"
  enable_ip_forwarding = false
  subnet_id = azurerm_subnet.example.id
}

# Crie um grupo de segurança de rede
resource "azurerm_network_security_group" "example" {
  name                 = "example-nsg"
  location             = azurerm_resource_group.example.location
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
  location             = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space        = ["10.0.0.0/16"]
}

    