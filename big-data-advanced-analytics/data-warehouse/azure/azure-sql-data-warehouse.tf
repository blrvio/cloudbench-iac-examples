
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Enable all features
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie um servidor SQL
resource "azurerm_sql_server" "example" {
  name                = "example-server"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  administrator_login = "admin"
  administrator_password = "P@$$wOrd"
}

# Crie um data warehouse
resource "azurerm_sql_data_warehouse" "example" {
  name                = "example-dw"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  edition            = "Enterprise"
  service_level       = "DW100c"
  server_name         = azurerm_sql_server.example.name
}

    