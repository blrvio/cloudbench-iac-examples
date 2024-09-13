
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Use para ativar recursos beta
}

# Crie um catálogo de dados
resource "azurerm_data_catalog" "example" {
  name     = "example-data-catalog"
  location = "West Europe" # Substitua pela região desejada
  resource_group_name = "example-resource-group"
}

# Crie um banco de dados no catálogo de dados
resource "azurerm_data_catalog_database" "example" {
  name     = "example-database"
  location = "West Europe" # Substitua pela região desejada
  data_catalog_name = azurerm_data_catalog.example.name
  resource_group_name = "example-resource-group"
}

# Crie uma tabela no banco de dados
resource "azurerm_data_catalog_table" "example" {
  name     = "example-table"
  location = "West Europe" # Substitua pela região desejada
  data_catalog_name = azurerm_data_catalog.example.name
  resource_group_name = "example-resource-group"
  database_name = azurerm_data_catalog_database.example.name
}

# Crie uma coluna na tabela
resource "azurerm_data_catalog_column" "example" {
  name     = "example-column"
  location = "West Europe" # Substitua pela região desejada
  data_catalog_name = azurerm_data_catalog.example.name
  resource_group_name = "example-resource-group"
  database_name = azurerm_data_catalog_database.example.name
  table_name = azurerm_data_catalog_table.example.name
}

    