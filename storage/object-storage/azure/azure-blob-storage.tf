
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Pode conter configurações adicionais
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe" # Substitua pela localização desejada
}

# Crie uma conta de armazenamento
resource "azurerm_storage_account" "example" {
  name                     = "examplestorage"
  resource_group_name     = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_redundancy        = "LRS"
}

# Crie um contêiner de blob
resource "azurerm_storage_container" "example" {
  name              = "example-container"
  storage_account_name = azurerm_storage_account.example.name
  public_access_level = "blob"
}

# Crie um blob
resource "azurerm_storage_blob" "example" {
  name              = "example-blob.txt"
  storage_account_name = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  source             = "file://path/to/your/file.txt" # Substitua pelo caminho para seu arquivo local
  type              = "BlockBlob"
  metadata          = {
    "key1" = "value1"
    "key2" = "value2"
  }
}
    