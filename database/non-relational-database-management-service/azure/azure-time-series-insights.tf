
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Ativa recursos para o Azure
}

# Crie um ambiente de Time Series Insights
resource "azurerm_time_series_insights_environment" "example" {
  name                       = "example-tsi-env"
  location                   = "westus2"
  resource_group_name        = "example-resources"
  sku_name                   = "S1"
  data_retention_time_in_days = 7
}

# Crie uma base de dados de Time Series Insights
resource "azurerm_time_series_insights_gen2_database" "example" {
  name                 = "example-tsi-db"
  location             = "westus2"
  resource_group_name  = "example-resources"
  environment_name     = azurerm_time_series_insights_environment.example.name
  partitioning_key     = "deviceId"
  data_retention_time = 365
}

# Crie uma referência para uma função de identidade gerenciada
resource "azurerm_identity" "example" {
  name = "example-identity"
  type = "systemassigned"
  resource_group_name = "example-resources"
}

# Crie um acesso de armazenamento para a base de dados
resource "azurerm_time_series_insights_storage_account_access" "example" {
  environment_name     = azurerm_time_series_insights_environment.example.name
  database_name       = azurerm_time_series_insights_gen2_database.example.name
  storage_account_name = "example-storage"
  identity_id         = azurerm_identity.example.id
  access_kind          = "ReadWrite"
}

# Crie um acesso de armazenamento para o ambiente
resource "azurerm_time_series_insights_storage_account_access" "example2" {
  environment_name     = azurerm_time_series_insights_environment.example.name
  storage_account_name = "example-storage"
  identity_id         = azurerm_identity.example.id
  access_kind          = "ReadWrite"
}

    