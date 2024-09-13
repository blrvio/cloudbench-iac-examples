
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use 'features {}' for the latest AzureRM provider features
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "westus2"
}

# Crie uma instância de servidor de metal nu
resource "azurerm_bare_metal_server" "server" {
  name                = "my-bare-metal-server"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_A80_v2"
  os_disk             = "Standard_LRS"
  offer               = "Standard_A80_v2"
  sku                 = "Standard_A80_v2"
  hardware_profile     = "SAP"
  network_interface_id = azurerm_network_interface.nic.id
  public_ip_address_id = azurerm_public_ip.ip.id
}

# Crie uma interface de rede
resource "azurerm_network_interface" "nic" {
  name                = "my-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id          = azurerm_subnet.subnet.id
  private_ip_address = "10.0.0.4"
}

# Crie uma rede virtual
resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

# Crie uma sub-rede
resource "azurerm_subnet" "subnet" {
  name                 = "my-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Crie um endereço IP público
resource "azurerm_public_ip" "ip" {
  name                = "my-public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method  = "Static"
}

    