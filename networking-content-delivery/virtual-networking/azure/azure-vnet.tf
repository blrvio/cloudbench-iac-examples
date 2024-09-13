
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Configure recursos adicionais
}

# Crie uma rede virtual
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = "West Europe" # Substitua pela região desejada
  resource_group_name = "example-rg" # Substitua pelo nome do grupo de recursos
  address_space       = ["10.0.0.0/16"]
}

# Crie um sub-rede
resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name = "example-rg" # Substitua pelo nome do grupo de recursos
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

    