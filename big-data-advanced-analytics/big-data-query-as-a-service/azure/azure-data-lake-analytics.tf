
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Use a versão mais recente do provedor do Azure
}

# Crie um recurso de Data Lake Analytics
resource "azurerm_data_lake_analytics_account" "example" {
  name                = "example-datalakeanalytics"
  resource_group_name = "example-resources"
  location            = "westus2"
  default_data_lake_store = "example-data-lake-store"
}

# Crie uma conta de armazenamento para o Data Lake Store
resource "azurerm_storage_account" "example" {
  name                     = "example-datalakestorage"
  resource_group_name      = "example-resources"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
    