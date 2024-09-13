
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use features para habilitar recursos pré-lançados
}

# Crie um servidor Azure PostgreSQL
resource "azurerm_postgresql_server" "main" {
  name                = "mypostgresqldb"
  resource_group_name = "myresourcegroup"
  location            = "eastus"
  administrator_login = "myadmin"
  administrator_password = "mypassword" # Substitua por uma senha forte
  version              = "13"
  sku_name            = "GP_Gen5_2"
  storage_mb          = 1024
  backup_retention_days = 7
}

# Crie um banco de dados no servidor PostgreSQL
resource "azurerm_postgresql_database" "main" {
  name               = "mydb"
  server_name         = azurerm_postgresql_server.main.name
  resource_group_name = azurerm_postgresql_server.main.resource_group_name
}
    