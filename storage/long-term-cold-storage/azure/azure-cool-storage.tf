
    # Configure the Azure Provider
provider "azurerm" {
  features {} # This is an optional block to enable new features
}

# Create a storage account with the Cool Storage Tier
resource "azurerm_storage_account" "cool_storage" {
  name                     = "mycoolstorageaccount"
  resource_group_name     = "myresourcegroup"
  location                 = "westus2"
  account_tier             = "Cool"
  account_replication_type = "LRS"
  # This is an optional block to enable the 'blob' service
  # For cool storage you need to enable it
  # This can be enabled for other tiers as well
  # If this is not enabled, then an error will be returned
  # If it is enabled on a storage account with a different tier, it is ignored.
  # To see if your storage account has the blob service enabled, you can use the azurerm_storage_account_blob_service resource.
  blob_service {
    enabled = true
  }
}

# Example of creating a blob container
resource "azurerm_storage_container" "cool_storage" {
  name                = "mycoolcontainer"
  storage_account_name = azurerm_storage_account.cool_storage.name
  # Optional: Set public access levels
  # public_access = "container"
  # Optional: Enable versioning
  # versioning = true
}

  