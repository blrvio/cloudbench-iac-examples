
      # Configure o provedor Azure
provider "azurerm" {
  features {}
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe"
}

# Crie uma conta de armazenamento
resource "azurerm_storage_account" "example" {
  name                     = "examplestorage"
  resource_group_name       = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Crie um sistema de arquivos
resource "azurerm_storage_file_share" "example" {
  name                 = "example-share"
  storage_account_name = azurerm_storage_account.example.name
  static_website {
    index_document = "index.html"
    error_404_document = "404.html"
  }
}
    