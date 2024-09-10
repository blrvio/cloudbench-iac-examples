
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "main" {
  name                     = "mystorageaccount"
  resource_group_name     = "myresourcegroup"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Enable Queue service
  enable_queue = true
}

# Create an Azure Storage Queue
resource "azurerm_storage_queue" "main" {
  name                 = "myqueue"
  storage_account_name = azurerm_storage_account.main.name
}

# Create an Azure Storage Queue Message
resource "azurerm_storage_queue_message" "main" {
  queue_name        = azurerm_storage_queue.main.name
  storage_account_name = azurerm_storage_account.main.name
  content           = "Hello, world!"
}

  