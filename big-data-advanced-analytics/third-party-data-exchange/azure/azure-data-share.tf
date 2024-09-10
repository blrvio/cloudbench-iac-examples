
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable features as needed
}

# Create a Data Share
resource "azurerm_data_share" "example" {
  name                 = "example-data-share"
  location              = "westus2"
  resource_group_name = "example-resource-group"
  account_id           = "1234567890123456"
  # Specify the share kind
  kind                 = "Share"
}

# Create a Data Share Dataset
resource "azurerm_data_share_dataset" "example" {
  name                 = "example-data-share-dataset"
  location              = "westus2"
  resource_group_name = "example-resource-group"
  data_share_name      = azurerm_data_share.example.name
  kind                 = "SynapseWorkspace"
  source_data_set_id = "my-synapse-workspace-id"
}

# Create a Data Share Recipient
resource "azurerm_data_share_recipient" "example" {
  name                 = "example-data-share-recipient"
  location              = "westus2"
  resource_group_name = "example-resource-group"
  data_share_name      = azurerm_data_share.example.name
  target_subscription_id = "00000000-0000-0000-0000-000000000000"
  target_resource_id   = "my-target-resource-id"
}

  