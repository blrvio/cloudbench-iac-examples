
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable features
}

# Create an Azure Time Series Insights environment
resource "azurerm_time_series_insights_environment" "example" {
  name                = "example-env"
  location             = "westus2"
  resource_group_name = "example-resources"
  data_retention_time = "P1D"
  # Specify the storage account where the environment will store data
  storage_account_id = azurerm_storage_account.example.id
  # Configure the environment's access policy
  access_policy {
    name = "example-policy"
    # Specify what operations can be performed on the environment
    principal_object_id = "[your-application-principal-object-id]"
    permissions = ["Read", "Write"]
  }
  # Define tags to categorize the environment
  tags = {
    Environment = "Production"
  }
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "example-storage"
  resource_group_name     = "example-resources"
  location                  = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Enable access to the storage account from Azure Time Series Insights
  allow_blob_public_access = false
  # Define tags to categorize the storage account
  tags = {
    Storage = "Time Series Data"
  }
}

# Create an Azure Time Series Insights Gen2 environment
resource "azurerm_time_series_insights_gen2_environment" "example" {
  name                     = "example-gen2-env"
  resource_group_name     = "example-resources"
  location                  = "westus2"
  # Specify the storage account where the environment will store data
  storage_account_id = azurerm_storage_account.example.id
  # Define tags to categorize the environment
  tags = {
    Environment = "Production"
  }
  # Configure the environment's access policy
  access_policy {
    name = "example-policy"
    # Specify what operations can be performed on the environment
    principal_object_id = "[your-application-principal-object-id]"
    permissions = ["Read", "Write"]
  }
}

# Create an Azure Time Series Insights Gen2 Ingestion destination
resource "azurerm_time_series_insights_gen2_ingress_destination" "example" {
  name                     = "example-ingestion-destination"
  resource_group_name     = "example-resources"
  location                  = "westus2"
  time_series_insights_gen2_environment_name = azurerm_time_series_insights_gen2_environment.example.name
  # Specify the storage account where the ingestion destination will store data
  storage_account_id = azurerm_storage_account.example.id
  # Define tags to categorize the ingestion destination
  tags = {
    IngestionDestination = "Time Series Data"
  }
}

# Create an Azure Time Series Insights Gen2 Ingestion endpoint
resource "azurerm_time_series_insights_gen2_ingress_endpoint" "example" {
  name                     = "example-ingestion-endpoint"
  resource_group_name     = "example-resources"
  location                  = "westus2"
  time_series_insights_gen2_environment_name = azurerm_time_series_insights_gen2_environment.example.name
  # Specify the ingestion destination where the ingestion endpoint will store data
  time_series_insights_gen2_ingress_destination_name = azurerm_time_series_insights_gen2_ingress_destination.example.name
  # Define tags to categorize the ingestion endpoint
  tags = {
    IngestionEndpoint = "Time Series Data"
  }
}

  