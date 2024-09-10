
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Ensure latest features are enabled
}

# Create a Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "example-storage-account"
  resource_group_name     = "example-resource-group"
  location                 = "westus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Optional: Set the storage account type
  account_type = "BlobStorage"
}

# Create a Container in the Storage Account
resource "azurerm_storage_container" "example" {
  name                = "example-container"
  storage_account_name = azurerm_storage_account.example.name
}

# Create a Blob in the Container
resource "azurerm_storage_blob" "example" {
  name                = "example-blob"
  storage_account_name = azurerm_storage_account.example.name
  container_name      = azurerm_storage_container.example.name
  source               = "example.txt" # Path to your local file
  # Optional: Set the Content Type
  content_type = "text/plain"
}

  