
    # Configure the Azure Provider
provider "azurerm" {
  features {} # This is required for the `azurerm_sql_server_stretch_database` resource
}

# Create a SQL Server Stretch Database
resource "azurerm_sql_server_stretch_database" "example" {
  name                   = "example-stretch-db"
  sql_server_name        = "example-server"
  sql_database_name      = "example-database"
  location               = "westus2"
  resource_group_name = "example-resources"

  # Optional properties
  retention_period_in_days = 180
  # You can specify additional configuration options as needed
}

# Create a SQL Server
resource "azurerm_sql_server" "example" {
  name                = "example-server"
  resource_group_name = "example-resources"
  location             = "westus2"
  version              = "2019-08-06-GA"
  administrator_login  = "sa"
  administrator_password = "<password>" # Replace with a strong password
  # Additional configuration options as needed
}

# Create a SQL Database
resource "azurerm_sql_database" "example" {
  name                = "example-database"
  resource_group_name = "example-resources"
  location             = "westus2"
  server_name         = azurerm_sql_server.example.name
  # Additional configuration options as needed
}

# Create a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westus2"
}

  