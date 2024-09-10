
    # Configure the Azure Provider
provider "azurerm" {
  features {}  
}

# Create a Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "westus2"
}

# Create an Azure Cognitive Services Account
resource "azurerm_cognitive_account" "main" {
  name                = "my-text-analytics-account"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "TextAnalytics"
  sku {
    name     = "F0"
    tier     = "Free"
  }
}

# Create a Text Analytics Key
resource "azurerm_cognitive_account_key" "main" {
  cognitive_account_name = azurerm_cognitive_account.main.name
  resource_group_name  = azurerm_resource_group.main.name
  key_type             = "primary"
  # Suppressing the key output for security reasons
  # key = "..."
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "main" {
  name                     = "mystorageaccount"
  resource_group_name     = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Suppressing the primary_access_key output for security reasons
  # primary_access_key = "..."
}

# Create an Azure Blob Container
resource "azurerm_storage_container" "main" {
  name                  = "myblobcontainer"
  storage_account_name = azurerm_storage_account.main.name
  # Suppressing the access_tier output
  # access_tier = "Hot"
}

  