
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create a Storage Account
resource "azurerm_storage_account" "main" {
  name                     = "mystorageaccount"
  resource_group_name      = "myresourcegroup"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Enable Azure Files
  enable_fileshare = true
}

# Create a File Share
resource "azurerm_storage_share" "main" {
  name                     = "myshare"
  storage_account_name     = azurerm_storage_account.main.name
  resource_group_name      = azurerm_storage_account.main.resource_group_name
  static_metadata          = {
    "key1" = "value1"
    "key2" = "value2"
  }
}

# Create a File Share User
resource "azurerm_storage_share_user" "main" {
  name                     = "myshareuser"
  storage_account_name     = azurerm_storage_account.main.name
  resource_group_name      = azurerm_storage_account.main.resource_group_name
  share_name               = azurerm_storage_share.main.name
  permissions              = "rw"
}

# Create a File Service SAS
resource "azurerm_storage_share_sas" "main" {
  name                     = "myshare-sas"
  storage_account_name     = azurerm_storage_account.main.name
  resource_group_name      = azurerm_storage_account.main.resource_group_name
  share_name               = azurerm_storage_share.main.name
  start                   = "2023-01-01T00:00:00Z"
  expiry                  = "2024-01-01T00:00:00Z"
  permissions             = "rwdl"
}

  