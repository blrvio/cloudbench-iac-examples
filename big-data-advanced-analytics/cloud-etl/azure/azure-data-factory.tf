
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create a Data Factory
resource "azurerm_data_factory" "example" {
  name                = "example-data-factory"
  location            = "westus2"
  resource_group_name = "example-resource-group"
}

# Create a Linked Service
resource "azurerm_data_factory_linked_service" "example" {
  name                = "example-linked-service"
  data_factory_name = azurerm_data_factory.example.name
  resource_group_name = azurerm_data_factory.example.resource_group_name
  type                = "AzureBlobStorage"
  # Add connection string here
  connection_string = "[Replace this with your connection string]"
}

# Create a Pipeline
resource "azurerm_data_factory_pipeline" "example" {
  name                = "example-pipeline"
  data_factory_name = azurerm_data_factory.example.name
  resource_group_name = azurerm_data_factory.example.resource_group_name
}

# Create a Data Flow
resource "azurerm_data_factory_data_flow" "example" {
  name                = "example-data-flow"
  data_factory_name = azurerm_data_factory.example.name
  resource_group_name = azurerm_data_factory.example.resource_group_name
}

  