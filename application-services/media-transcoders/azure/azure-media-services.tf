
    # Configure the Azure provider
provider "azurerm" {
  features {} # Use the latest Azure API version
}

# Create an Azure Media Services account
resource "azurerm_media_services_account" "main" {
  name                = "mymediaservicesaccount"
  location            = "westus2"
  resource_group_name = "myresourcegroup"
  storage_account     = "mystorageaccount"
}

# Create an Azure Media Services storage account
resource "azurerm_storage_account" "main" {
  name                = "mystorageaccount"
  resource_group_name = "myresourcegroup"
  location            = "westus2"
  account_tier        = "Standard"
  account_replication_type = "LRS"
}

# Create an Azure Media Services streaming endpoint
resource "azurerm_media_services_streaming_endpoint" "main" {
  name                = "mystreamingenpoint"
  resource_group_name = "myresourcegroup"
  account_name        = azurerm_media_services_account.main.name
  location            = "westus2"
  scale_units         = 2
}

# Create an Azure Media Services content key
resource "azurerm_media_services_content_key" "main" {
  name                = "mycontentkey"
  resource_group_name = "myresourcegroup"
  account_name        = azurerm_media_services_account.main.name
  key_delivery_type = "OnDemand"
  clear_key_type      = "Software"
  key_value = "[YOUR CONTENT KEY VALUE]"
}

# Create an Azure Media Services asset
resource "azurerm_media_services_asset" "main" {
  name                = "myasset"
  resource_group_name = "myresourcegroup"
  account_name        = azurerm_media_services_account.main.name
  # Set the storage container for the asset
  storage_container_name = "mycontainer"
}

# Create an Azure Media Services locator
resource "azurerm_media_services_locator" "main" {
  name                = "mylocator"
  resource_group_name = "myresourcegroup"
  account_name        = azurerm_media_services_account.main.name
  asset_name         = azurerm_media_services_asset.main.name
  # Set the type of locator (for example, on-demand or streaming)
  type = "OnDemand"
}

# Create an Azure Media Services streaming policy
resource "azurerm_media_services_streaming_policy" "main" {
  name                = "mystreamingpolicy"
  resource_group_name = "myresourcegroup"
  account_name        = azurerm_media_services_account.main.name
  # Set the streaming policy settings
  # For example, you can specify the default content key used for encryption
  default_content_key = azurerm_media_services_content_key.main.id
}

  