
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Habilita as funcionalidades mais recentes do provedor
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie um servidor SQL Database Edge
resource "azurerm_sql_server" "example" {
  name                = "example-server"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  administrator_login  = "admin"
  administrator_password = "<your-password>" # Substitua pela sua senha
  version              = "v12"
  edition              = "Standard"
  license_type         = "BasePrice"
}

# Crie um banco de dados SQL Database Edge
resource "azurerm_sql_database" "example" {
  name              = "example-database"
  resource_group_name = azurerm_resource_group.example.name
  server_name        = azurerm_sql_server.example.name
  edition             = "Standard"
  max_size_gb        = 10
  collation           = "SQL_Latin1_General_CP1_CI_AS"
}

# Crie um usuário do banco de dados SQL Database Edge
resource "azurerm_sql_user" "example" {
  name              = "example-user"
  resource_group_name = azurerm_resource_group.example.name
  server_name        = azurerm_sql_server.example.name
  login              = "user"
  password            = "<your-password>" # Substitua pela sua senha
}

# Crie uma regra de firewall para o servidor SQL Database Edge
resource "azurerm_sql_firewall_rule" "example" {
  name              = "example-firewall-rule"
  resource_group_name = azurerm_resource_group.example.name
  server_name        = azurerm_sql_server.example.name
  start_ip_address   = "0.0.0.0"
  end_ip_address     = "0.0.0.0"
}

    