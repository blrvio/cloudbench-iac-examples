
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable Azure features for Terraform
}

# Create an Azure Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "eastus"
}

# Create an Azure SQL Server
resource "azurerm_sql_server" "main" {
  name                = "my-sql-server"
  resource_group_name = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  version              = "12.0"
  administrator_login  = "myadmin"
  administrator_password = "MyStrongPassword!" # Replace with a strong password
}

# Create an Azure SQL Database
resource "azurerm_sql_database" "main" {
  name                = "my-sql-database"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_sql_server.main.name
  location             = azurerm_resource_group.main.location
  # Optional: Define the database edition
  edition = "Standard"
  # Optional: Define the database service tier
  service_tier = "S0"
}

# Create an Azure SQL Database Firewall Rule
resource "azurerm_sql_firewall_rule" "main" {
  name                = "allow-my-ip"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_sql_server.main.name
  start_ip_address     = "127.0.0.1"
  end_ip_address       = "127.0.0.1"
}

  