
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Time Series Insights Environment
resource "azurerm_time_series_insights_environment" "main" {
  name                       = "my-time-series-insights-environment"
  location                   = "westus2"
  resource_group_name         = "my-resource-group"
  sku {
    name = "S1"
  }
  data_retention_time_in_days = 7
  # Optional: Configure the access policy
  # access_policies {
  #   name = "access-policy"
  #   principal_object_id = "your-principal-object-id"
  #   permission = "ReadWrite"
  # }
  # Optional: Configure the ingress settings
  # ingress_settings {
  #   event_source_types = ["IoTEventSource", "EventHubEventSource"]
  # }
}

# Create an Azure Time Series Insights Gen 2 Environment
resource "azurerm_time_series_insights_gen2_environment" "main" {
  name                       = "my-time-series-insights-gen2-environment"
  location                   = "westus2"
  resource_group_name         = "my-resource-group"
  sku {
    name = "S1"
  }
  # Optional: Configure the storage settings
  # storage_settings {
  #   type = "StorageAccount"
  #   storage_account_name = "your-storage-account-name"
  #   container_name = "your-container-name"
  #   storage_account_key = "your-storage-account-key"
  # }
  # Optional: Configure the ingress settings
  # ingress_settings {
  #   event_source_types = ["IoTEventSource", "EventHubEventSource"]
  # }
}

# Create an Azure Time Series Insights Gen 2 Ingestion Endpoint
resource "azurerm_time_series_insights_gen2_ingestion_endpoint" "main" {
  name                       = "my-ingestion-endpoint"
  environment_name            = azurerm_time_series_insights_gen2_environment.main.name
  resource_group_name         = "my-resource-group"
  location                   = "westus2"
  # Optional: Configure the event source type
  # event_source_type = "IoTEventSource"
}

# Create an Azure Time Series Insights Gen 2 Query Endpoint
resource "azurerm_time_series_insights_gen2_query_endpoint" "main" {
  name                       = "my-query-endpoint"
  environment_name            = azurerm_time_series_insights_gen2_environment.main.name
  resource_group_name         = "my-resource-group"
  location                   = "westus2"
}

  