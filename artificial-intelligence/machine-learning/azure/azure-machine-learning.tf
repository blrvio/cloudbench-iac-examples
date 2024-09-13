
      # Configure o provedor Azure
provider "azurerm" {
  features {}  # Usar recursos mais recentes
}

# Crie um workspace de Machine Learning
resource "azurerm_machine_learning_workspace" "example" {
  name                     = "my-ml-workspace"
  location                 = "westus2"
  resource_group_name     = "my-resource-group"
  storage_account_name     = "my-storage-account"
  application_insights_name = "my-app-insights"
  keyvault_name           = "my-keyvault"
  # ...
}

# Crie um modelo de Machine Learning
resource "azurerm_machine_learning_model" "example" {
  name                 = "my-model"
  workspace_id          = azurerm_machine_learning_workspace.example.id
  description           = "My custom model"
  # ...
}

# Crie um pipeline de Machine Learning
resource "azurerm_machine_learning_pipeline" "example" {
  name                 = "my-pipeline"
  workspace_id          = azurerm_machine_learning_workspace.example.id
  description           = "My custom pipeline"
  # ...
}

# Crie uma versão de modelo
resource "azurerm_machine_learning_model_version" "example" {
  name                 = "my-model-version"
  workspace_id          = azurerm_machine_learning_workspace.example.id
  model_id              = azurerm_machine_learning_model.example.id
  # ...
}
    