
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Configure recursos adicionais
}

# Crie um servidor SQL
source "local-file" "sql_server_config" {
  filename = "sql_server_config.json"
}
resource "azurerm_sql_server" "main" {
  name                = "sqlserver-${random_id.sqlserver.hex}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  administrator_login = "admin"
  administrator_password = local-file.sql_server_config.administrator_password
  version             = "2019-12"
}

# Crie um banco de dados SQL
resource "azurerm_sql_database" "main" {
  name                 = "sqldb-${random_id.sqldb.hex}"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_sql_server.main.name
  location            = azurerm_resource_group.main.location
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "main" {
  name     = "rg-${random_id.rg.hex}"
  location = "West Europe"
}

# Crie um ID aleatório para os nomes dos recursos
resource "random_id" "sqlserver" {
  byte_length = 4
}
resource "random_id" "sqldb" {
  byte_length = 4
}
resource "random_id" "rg" {
  byte_length = 4
}
    