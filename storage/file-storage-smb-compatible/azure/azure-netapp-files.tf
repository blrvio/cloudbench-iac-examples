
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure NetApp Files Account
resource "azurerm_netapp_account" "main" {
  name                = "my-netapp-account"
  location            = "westus2"
  resource_group_name = "my-resource-group"
}

# Create an Azure NetApp Files Capacity Pool
resource "azurerm_netapp_capacity_pool" "main" {
  name                = "my-capacity-pool"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  account_name         = azurerm_netapp_account.main.name
  service_level        = "Standard"
  size_giB             = 1024
}

# Create an Azure NetApp Files Volume
resource "azurerm_netapp_volume" "main" {
  name                = "my-volume"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  account_name         = azurerm_netapp_account.main.name
  capacity_pool_id     = azurerm_netapp_capacity_pool.main.id
  service_level        = "Standard"
  size_giB             = 1024
}

# Create a Subnet for Azure NetApp Files
resource "azurerm_subnet" "main" {
  name                 = "my-subnet"
  resource_group_name = "my-resource-group"
  virtual_network_name = "my-vnet"
  address_prefixes     = ["10.0.0.0/24"]
}

# Create an Azure NetApp Files Mount Target
resource "azurerm_netapp_mount_target" "main" {
  name                = "my-mount-target"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  account_name         = azurerm_netapp_account.main.name
  capacity_pool_id     = azurerm_netapp_capacity_pool.main.id
  subnet_id           = azurerm_subnet.main.id
  security_style       = "gen2"
}

  