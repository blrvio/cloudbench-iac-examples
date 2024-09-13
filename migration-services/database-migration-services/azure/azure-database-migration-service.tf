
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Use AzureRM features
}

# Crie um serviço de migração de banco de dados
resource "azurerm_dms_instance" "example" {
  name                = "example-dms"
  location            = "eastus"
  resource_group_name = "example-resources"

  # Use um SKU padrão, mas você pode escolher outro
  sku {
    name     = "Standard"
    tier    = "Standard"
    capacity = 1
  }
}

# Crie uma tarefa de migração
resource "azurerm_dms_task" "example" {
  name                     = "example-task"
  resource_group_name      = "example-resources"
  dms_instance_name       = azurerm_dms_instance.example.name
  source_connection_name  = "example-source-connection"
  target_connection_name = "example-target-connection"

  # Crie a tarefa de migração, usando uma opção de migração pré-definida
  # Você pode configurar outras opções de migração
  task_type = "FullMigrationTask"

  # Defina as configurações de migração (exemplo: SQL Server para Azure SQL)
  # Se necessário, configure outras opções de migração
  sql_server_migration {
    source_server_version        = "SQL Server 2019"
    target_server_version        = "Azure SQL Database v12"
    target_server_edition        = "General Purpose"
    target_server_compute_units = 2
  }
}

    