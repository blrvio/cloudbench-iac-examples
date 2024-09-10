
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable the latest features
}

# Create a Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "westus2"
}

# Create a SQL Server
resource "azurerm_sql_server" "main" {
  name                = "mysqlsvr"
  resource_group_name = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  version              = "2022-08-01-preview"
  administrator_login = "sa"
  administrator_password = "Password123!" # Replace with a secure password
}

# Create a SQL Database
resource "azurerm_sql_database" "main" {
  name                = "mydb"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_sql_server.main.name
  edition             = "Standard"
  location             = azurerm_resource_group.main.location
  # Optional: Enable geo-replication
  # geo_replication_enabled = true
}

# Create a SQL Database Edge Deployment
resource "azurerm_sql_database_edge_deployment" "main" {
  name                = "myedgedeployment"
  resource_group_name = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  sql_server_name     = azurerm_sql_server.main.name
  sql_database_name    = azurerm_sql_database.main.name
  # Configure the deployment parameters based on your specific needs
}

  