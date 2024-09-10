
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Data Catalog
resource "azurerm_data_catalog" "example" {
  name                 = "example-data-catalog"
  resource_group_name = "example-resource-group"
  location             = "westus2"
  # Optional settings
  # tags = {
  #   Name = "example-data-catalog"
  # }
}

# Create an Azure Data Catalog principal
resource "azurerm_data_catalog_principal" "example" {
  name                 = "example-data-catalog-principal"
  resource_group_name = "example-resource-group"
  data_catalog_name  = azurerm_data_catalog.example.name
  # Optional settings
  # type = "ServicePrincipal"
  # identity_type = "ServicePrincipal"
  # service_principal_id = "example-sp-id"
}

# Create an Azure Data Catalog glossary
resource "azurerm_data_catalog_glossary" "example" {
  name                 = "example-glossary"
  resource_group_name = "example-resource-group"
  data_catalog_name  = azurerm_data_catalog.example.name
  # Optional settings
  # description = "example-description"
}

# Create an Azure Data Catalog glossary term
resource "azurerm_data_catalog_glossary_term" "example" {
  name                 = "example-glossary-term"
  resource_group_name = "example-resource-group"
  data_catalog_name  = azurerm_data_catalog.example.name
  glossary_name        = azurerm_data_catalog_glossary.example.name
  # Optional settings
  # definition = "example-definition"
  # description = "example-description"
}

  