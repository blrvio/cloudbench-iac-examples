
    # Configure the Azure provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Create an Azure Database for PostgreSQL server
resource "azurerm_postgresql_server" "example" {
  name                = "example-server"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  administrator_login = "exampleadmin"
  administrator_password = "ExamplePassword123!"  # Please change this in your real code
  version              = "13"
  sku {
    name     = "B_Gen5_1"
    tier     = "Basic"
    capacity = 1
  }
}

# Create a PostgreSQL database
resource "azurerm_postgresql_database" "example" {
  name                = "example-db"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_postgresql_server.example.name
}

  