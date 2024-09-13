
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Utilize recursos mais recentes (opcional)
}

# Crie um servidor do Azure Database for MySQL
resource "azurerm_mysql_server" "example" {
  name                = "example-mysql-server"
  location            = "westus2"
  resource_group_name = "example-resources"
  administrator_login = "myadmin"
  administrator_password = "P@$$w0rd!"
  version             = "5.7"
  sku_name            = "GP_Gen5_2"
}

# Crie um banco de dados no servidor
resource "azurerm_mysql_database" "example" {
  name                = "example-db"
  resource_group_name = "example-resources"
  server_name          = azurerm_mysql_server.example.name
  charset              = "utf8mb4"
  collation            = "utf8mb4_general_ci"
}

# Crie um usuário com acesso ao banco de dados
resource "azurerm_mysql_user" "example" {
  name                = "example-user"
  resource_group_name = "example-resources"
  server_name          = azurerm_mysql_server.example.name
  login               = "exampleuser"
  password            = "P@$$w0rd!"
}

# Conceda permissões ao usuário para o banco de dados
resource "azurerm_mysql_user_database" "example" {
  name                = "example-user"
  resource_group_name = "example-resources"
  server_name          = azurerm_mysql_server.example.name
  database_name        = azurerm_mysql_database.example.name
}

    