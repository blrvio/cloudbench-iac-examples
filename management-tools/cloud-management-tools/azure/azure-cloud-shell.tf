
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Optional, to enable features
}

# Create an Azure Cloud Shell Profile
resource "azurerm_cloud_shell_profile" "example" {
  name     = "example-profile"
  location = "westus2"
  # The Storage Account to store Cloud Shell data
  storage_account_id = azurerm_storage_account.example.id
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "example-storageaccount"
  resource_group_name      = "example-resources"
  location                  = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

  