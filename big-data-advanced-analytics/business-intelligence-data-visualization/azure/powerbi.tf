
    # Configure the Azure provider
provider "azurerm" {
  features {} # Use this to enable features in the provider
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "powerbi-rg"
  location = "westus2"
}

# Create a workspace
resource "azurerm_power_bi_workspace" "example" {
  name                  = "powerbi-ws"
  resource_group_name = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  # Set capacity for workspace, default is Standard, see documentation
  capacity               = "Premium"
}

# Create a Power BI Embedded capacity
resource "azurerm_power_bi_embedded_capacity" "example" {
  name                  = "powerbi-embedded-capacity"
  resource_group_name = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  sku {
    name     = "A4"
    tier     = "A"
    capacity = "P1"
  }
}

# Create a Power BI Embedded Workspace Collection
resource "azurerm_power_bi_embedded_workspace_collection" "example" {
  name                  = "powerbi-embedded-workspace-collection"
  resource_group_name = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  capacity_id          = azurerm_power_bi_embedded_capacity.example.id
}

# Create a Power BI Embedded Workspace
resource "azurerm_power_bi_embedded_workspace" "example" {
  name                  = "powerbi-embedded-workspace"
  resource_group_name = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  collection_id        = azurerm_power_bi_embedded_workspace_collection.example.id
}

  