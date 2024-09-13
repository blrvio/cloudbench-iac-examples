
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Define o provedor Azure
}

# Crie um grupo de recursos Azure
resource "azurerm_resource_group" "example" {
  name     = "cosmosdb-rg" # Nome do grupo de recursos
  location = "westus" # Região desejada
}

# Crie uma conta do Azure Cosmos DB
resource "azurerm_cosmosdb_account" "example" {
  name                = "example-cosmosdb"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  kind                = "GlobalDocumentDB"
  offer_type          = "Standard"
  consistency_policy {
    consistency_level = "Session"
  }
  location_mode       = "Regional"
  capacity {
    throughput = 4000
  }
}

# Crie um banco de dados
resource "azurerm_cosmosdb_database" "example" {
  name                = "example-database"
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_cosmosdb_account.example.name
}

# Crie um contêiner
resource "azurerm_cosmosdb_container" "example" {
  name                = "example-container"
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_cosmosdb_account.example.name
  database_name       = azurerm_cosmosdb_database.example.name
  throughput          = 4000
  partition_key_path  = "/id"
}

    