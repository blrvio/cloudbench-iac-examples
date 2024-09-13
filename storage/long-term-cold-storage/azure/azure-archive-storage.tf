
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Configure as features que você precisa
}

# Crie um container de armazenamento
resource "azurerm_storage_account" "example" {
  name                     = "example-storage-account"
  resource_group_name      = "example-resource-group"
  location                  = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Crie uma política de acesso para o container
resource "azurerm_storage_blob_container" "example" {
  name                     = "example-container"
  storage_account_name     = azurerm_storage_account.example.name
  public_access             = "none"
}

# Crie um arquivo de arquivo
resource "azurerm_storage_blob" "example" {
  name                  = "example-blob"
  storage_account_name  = azurerm_storage_account.example.name
  container_name        = azurerm_storage_blob_container.example.name
  source                 = "path/to/your/blob"
  tier                  = "Archive"
  metadata               = {
    "key1" = "value1"
    "key2" = "value2"
  }
}

    