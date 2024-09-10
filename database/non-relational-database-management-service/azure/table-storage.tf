
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Ensure latest features are enabled
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "main" {
  name                     = "mystorageaccount"
  resource_group_name      = "myresourcegroup"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # You can choose different replication types for your needs
}

# Create an Azure Table
resource "azurerm_storage_table" "main" {
  name                 = "mytable"
  storage_account_name = azurerm_storage_account.main.name
  resource_group_name = "myresourcegroup"
}

  