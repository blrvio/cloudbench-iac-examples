
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Use recursos preview
}

# Crie um workspace do Databricks
resource "azurerm_databricks_workspace" "example" {
  name                = "example-databricks-workspace"
  resource_group_name = "example-resource-group"
  location            = "westus2"
  # ...
}

# Crie um cluster do Databricks
resource "azurerm_databricks_cluster" "example" {
  name                 = "example-databricks-cluster"
  workspace_id         = azurerm_databricks_workspace.example.id
  spark_version         = "11.3.x-scala2.12"
  node_type            = "Standard_DS3_v2"
  driver_node_count    = 1
  worker_node_count    = 2
  # ...
}

# Crie uma tabela de dados no workspace do Databricks
resource "azurerm_databricks_table" "example" {
  name                = "example-table"
  workspace_id         = azurerm_databricks_workspace.example.id
  storage_path        = "dbfs:/example/table.parquet"
  data_format         = "parquet"
  # ...
}
    