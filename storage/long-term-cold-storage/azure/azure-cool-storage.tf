
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Adicione features se necessário
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe"
}

# Crie uma conta de armazenamento
resource "azurerm_storage_account" "example" {
  name                     = "example-storage"
  resource_group_name       = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Crie um contêiner de armazenamento
resource "azurerm_storage_container" "example" {
  name                  = "example-container"
  storage_account_name = azurerm_storage_account.example.name
}

# Crie um blob de armazenamento frio
resource "azurerm_storage_blob" "example" {
  name                  = "example-blob"
  storage_account_name = azurerm_storage_account.example.name
  container_name       = azurerm_storage_container.example.name
  source                = "path/to/your/file"
  content_type          = "text/plain"
  tier                  = "Cool"
}

    