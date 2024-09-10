
    # Configure the Azure provider
provider "azurerm" {
  features {} # This is required to use the Azure Synapse Analytics resources
}

# Create a Synapse Workspace
resource "azurerm_synapse_workspace" "main" {
  name                = "my-synapse-workspace"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  # Optional settings:
  # sql_administrator_login = "sql-admin"
  # sql_administrator_password = "password"
}

# Create a Synapse SQL Pool
resource "azurerm_synapse_sql_pool" "main" {
  name                = "my-sql-pool"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  workspace_name     = azurerm_synapse_workspace.main.name
  # Optional settings:
  # service_level = "S1"
  # storage_account_type = "Standard"
  # max_degree_of_parallelism = 8
}

# Create a Synapse Spark Pool
resource "azurerm_synapse_spark_pool" "main" {
  name                = "my-spark-pool"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  workspace_name     = azurerm_synapse_workspace.main.name
  # Optional settings:
  # node_size = "Standard_DS3_v2"
  # node_count = 4
  # auto_scale {
  #   min_node_count = 2
  #   max_node_count = 8
  # }
}

# Create a Synapse Linked Service
resource "azurerm_synapse_linked_service" "main" {
  name                = "my-linked-service"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  workspace_name     = azurerm_synapse_workspace.main.name
  # Define the type of linked service
  type = "AzureBlobStorage"
  # Configure the linked service based on the type
  # For example, for AzureBlobStorage:
  # connection_string = "DefaultEndpointsProtocol=https;AccountName=mystorageaccount;AccountKey=key"
}

# Create a Synapse Pipeline
resource "azurerm_synapse_pipeline" "main" {
  name                = "my-pipeline"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  workspace_name     = azurerm_synapse_workspace.main.name
  # Optional settings:
  # access_control {
  #   access_right = "AllAccess"
  # }
}

  