
    # Configure the Azure Provider
provider "azurerm" {
  features {} 
}

# Create an Azure Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "westus2"
}

# Create a MySQL Server
resource "azurerm_mysql_server" "main" {
  name                = "my-mysql-server"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  administrator_login  = "myadmin"
  administrator_password = "P@$$wOrd"
  sku {
    name     = "GP_Gen5_2"
    tier     = "GeneralPurpose"
    capacity = 2
  }
  version  = "5.7"
  # Optional: Enable SSL for secure connections
  ssl_enforcement = "Enabled"
}

# Create a MySQL Database
resource "azurerm_mysql_database" "main" {
  name                = "mydb"
  resource_group_name = azurerm_resource_group.main.name
  server_name        = azurerm_mysql_server.main.name
}

# Create a MySQL Server Firewall Rule
resource "azurerm_mysql_server_firewall_rule" "main" {
  name                = "allow-my-ip"
  resource_group_name = azurerm_resource_group.main.name
  server_name        = azurerm_mysql_server.main.name
  start_ip_address   = "10.0.0.0"
  end_ip_address     = "10.0.0.255"
}

  