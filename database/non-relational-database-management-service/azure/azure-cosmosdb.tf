
    # Configure the Azure provider
provider "azurerm" {
  features {} # Use the latest features
}

# Create a CosmosDB Account
resource "azurerm_cosmosdb_account" "main" {
  name                = "my-cosmosdb-account"
  location             = "westus2"
  resource_group_name = "my-resource-group"
  kind                 = "globalDocumentDB"
  # Set the default consistency level
  consistency_policy {
    consistency_level = "Session"
  }
  # Set the default capacity
  capabilities {
    enable_automatic_capacity = true
  }
}

# Create a CosmosDB database
resource "azurerm_cosmosdb_database" "main" {
  name                 = "my-database"
  resource_group_name  = azurerm_cosmosdb_account.main.resource_group_name
  account_name         = azurerm_cosmosdb_account.main.name
  # Set the default throughput for the database
  throughput            = 400
}

# Create a CosmosDB container
resource "azurerm_cosmosdb_container" "main" {
  name                 = "my-container"
  resource_group_name  = azurerm_cosmosdb_account.main.resource_group_name
  account_name         = azurerm_cosmosdb_account.main.name
  database_name        = azurerm_cosmosdb_database.main.name
  # Set the default throughput for the container
  throughput            = 400
  # Configure indexing policy
  indexing_policy {
    automatic = true
  }
}

  