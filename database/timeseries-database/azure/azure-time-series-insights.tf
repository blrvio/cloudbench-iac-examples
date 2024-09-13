
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Opcional: Habilita recursos beta
}

# Crie um ambiente do Azure Time Series Insights
resource "azurerm_time_series_insights_environment" "example" {
  name                = "example-env"
  location            = "westus2"
  resource_group_name = "example-rg"
  sku                 = "S1"
  data_retention_time = 365 # Dias
}

# Crie uma fonte de dados
resource "azurerm_time_series_insights_gen2_data_source" "example" {
  name                = "example-datasource"
  location            = "westus2"
  resource_group_name = "example-rg"
  environment_name    = azurerm_time_series_insights_environment.example.name
  kind               = "EventHub"
  event_hub_endpoint = "example-eventhub.servicebus.windows.net"
  event_hub_name      = "example-eventhub"
  event_hub_consumer_group = "example-consumergroup"
  shared_access_key      = "example-key"
}

# Crie uma referência de modelo de dados
resource "azurerm_time_series_insights_gen2_reference_data_set" "example" {
  name                = "example-reference-dataset"
  location            = "westus2"
  resource_group_name = "example-rg"
  environment_name    = azurerm_time_series_insights_environment.example.name
  data_source_name     = azurerm_time_series_insights_gen2_data_source.example.name
  key_properties      = ["Id", "name"]
  timestamp_properties = ["timestamp"]
  data_format         = "Avro"
  ingestion_properties = {
    batch_size = 1000 # Limite de eventos por lote
    interval   = 60 # Tempo entre lotes em segundos
  }
}
    