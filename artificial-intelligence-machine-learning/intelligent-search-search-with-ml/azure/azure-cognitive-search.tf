
    # Configure the Azure Provider
provider "azurerm" {
  features {}  # Enable all features
}

# Create a Cognitive Search service
resource "azurerm_search_service" "main" {
  name                = "my-search-service"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  sku {
    name = "free"
  }
  # Optional: Configure the hosting mode
  hosting_mode = "Standard"
  # Optional: Configure the partition key for the search service
  partition_key = "PartitionKey"
}

# Create a search index
resource "azurerm_search_index" "main" {
  name                = "my-search-index"
  resource_group_name = "my-resource-group"
  search_service_name = azurerm_search_service.main.name
  # Define the fields in the index
  fields = [
    {
      name     = "title"
      type     = "Edm.String"
      facetable = true
      searchable = true
    },
    {
      name     = "content"
      type     = "Edm.String"
      facetable = false
      searchable = true
    }
  ]
  # Optional: Configure the scoring profile for the index
  scoring_profiles = [
    {
      name     = "my-scoring-profile"
      text_fields = ["title", "content"]
    }
  ]
}

# Create a data source for the search index
resource "azurerm_search_data_source" "main" {
  name                = "my-data-source"
  resource_group_name = "my-resource-group"
  search_service_name = azurerm_search_service.main.name
  description = "Data source for the search index"
  # Define the connection string for the data source
  connection_string = "your_connection_string"
  # Define the data source type
  type = "azureblob"
  # Optional: Configure the credential information for the data source
  credentials {
    type = "basic"
    # Provide the username and password for the connection
    username = "your_username"
    password = "your_password"
  }
}

  