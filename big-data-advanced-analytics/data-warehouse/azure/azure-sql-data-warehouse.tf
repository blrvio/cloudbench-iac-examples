
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable experimental features
}

# Create a Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-sql-dw-rg"
  location = "westus2"
}

# Create a SQL Server
resource "azurerm_sql_server" "main" {
  name                = "my-sql-server"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  version             = "2017-10-01-core"
  administrator_login = "my-admin-user"
  administrator_password = "MyStrongPassword123"
}

# Create a SQL Data Warehouse
resource "azurerm_sql_database" "main" {
  name                = "my-sql-dw"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  server_name        = azurerm_sql_server.main.name
  edition             = "DataWarehouse"
  service_tier        = "Standard"
  max_size_gb        = 100
  # Add tags
  tags = {
    Environment = "Dev"
  }
}

  