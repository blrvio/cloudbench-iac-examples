
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Habilita recursos em pré-visualização
}

# Crie um grupo de recursos do Azure
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus"
}

# Crie uma conta de Batch
resource "azurerm_batch_account" "example" {
  name                = "example-batch-account"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  storage_account_type = "Standard_LRS"
  key_vault_reference {
    id = "keyvault-id"
  }
}

# Crie uma pool de computação
resource "azurerm_batch_pool" "example" {
  name                = "example-pool"
  account_name        = azurerm_batch_account.example.name
  resource_group_name = azurerm_resource_group.example.name
  vm_size              = "Standard_A2_v2"
  target_dedicated_nodes = 2
  allocation_mode      = "BatchService"
  user_account {
    name     = "admin"
    password = "password"
  }
}

# Crie um trabalho de Batch
resource "azurerm_batch_job" "example" {
  name                = "example-job"
  account_name        = azurerm_batch_account.example.name
  resource_group_name = azurerm_resource_group.example.name
  pool_id            = azurerm_batch_pool.example.id
}

# Crie uma tarefa de Batch
resource "azurerm_batch_task" "example" {
  name                = "example-task"
  account_name        = azurerm_batch_account.example.name
  resource_group_name = azurerm_resource_group.example.name
  job_id              = azurerm_batch_job.example.id
  command_line        = "echo Hello from Azure Batch"
}

    