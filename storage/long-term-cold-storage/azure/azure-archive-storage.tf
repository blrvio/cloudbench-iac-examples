
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Use features block to enable new features
}

# Create a storage account
resource "azurerm_storage_account" "main" {
  name                     = "mystorageaccount"
  resource_group_name     = "myresourcegroup"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Optional settings:
  # enable_https_traffic_only = true
  # minimum_tls_version = "TLS1_2"
}

# Create a storage container
resource "azurerm_storage_container" "main" {
  name                  = "mycontainer"
  storage_account_name = azurerm_storage_account.main.name
  # Optional settings:
  # public_access_level = "blob"
}

# Create an archive blob
resource "azurerm_storage_blob" "main" {
  name                  = "myarchiveblob.zip"
  storage_account_name = azurerm_storage_account.main.name
  container_name       = azurerm_storage_container.main.name
  source                = "path/to/local/file.zip"
  tier                  = "Archive"
}

# Create an access policy
resource "azurerm_storage_blob_container_access_policy" "main" {
  name                  = "mypolicy"
  storage_account_name = azurerm_storage_account.main.name
  container_name       = azurerm_storage_container.main.name
  # Define permissions:
  permissions = [
    "read",
    "write",
    "delete",
    "list"
  ]
  # Optional settings:
  # start = "2023-04-01T00:00:00Z"
  # expiry = "2024-04-01T00:00:00Z"
}

  