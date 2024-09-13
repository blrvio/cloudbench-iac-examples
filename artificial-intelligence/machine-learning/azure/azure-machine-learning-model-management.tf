
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Certifique-se de que todas as features estão habilitadas.
}

# Crie um workspace do Azure Machine Learning
resource "azurerm_machine_learning_workspace" "example" {
  name                = "example-workspace"
  resource_group_name = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  storage_account_name = azurerm_storage_account.example.name
  application_insights_instrumentation_key = azurerm_application_insights.example.instrumentation_key
  key_vault_id       = azurerm_key_vault.example.id
}

# Crie um modelo de Machine Learning
resource "azurerm_machine_learning_model" "example" {
  name                = "example-model"
  workspace_id       = azurerm_machine_learning_workspace.example.id
  description         = "Exemplo de modelo de Machine Learning"
  model_framework     = "TensorFlow"
  model_version        = "1.0"
  model_file_uri      = "https://mystorage.blob.core.windows.net/models/example-model.zip"
  model_size_in_kb    = 1024
  model_type           = "Classification"
  model_hash          = "hash-do-modelo"
  model_description   = "Descrição do modelo"
  model_properties    = {
    "prop1": "valor1"
    "prop2": "valor2"
  }
}

# Crie uma versão do modelo
resource "azurerm_machine_learning_model_version" "example" {
  name                = "example-model-version"
  workspace_id       = azurerm_machine_learning_workspace.example.id
  model_id            = azurerm_machine_learning_model.example.id
  model_version        = "1.1"
  model_file_uri      = "https://mystorage.blob.core.windows.net/models/example-model-v1.zip"
  model_size_in_kb    = 1024
  model_type           = "Classification"
  model_hash          = "hash-do-modelo-v1"
  model_description   = "Descrição do modelo v1"
  model_properties    = {
    "prop1": "valor1"
    "prop2": "valor2"
  }
}

# Importe o modelo de Machine Learning para um ambiente de destino
resource "azurerm_machine_learning_model_deployment" "example" {
  name                = "example-model-deployment"
  workspace_id       = azurerm_machine_learning_workspace.example.id
  endpoint_id         = azurerm_machine_learning_endpoint.example.id
  model_id            = azurerm_machine_learning_model.example.id
  model_version        = "1.0"
  description         = "Exemplo de implantação de modelo de Machine Learning"
}

# Crie um endpoint para hospedar os modelos
resource "azurerm_machine_learning_endpoint" "example" {
  name                = "example-endpoint"
  workspace_id       = azurerm_machine_learning_workspace.example.id
  description         = "Exemplo de endpoint de Machine Learning"
  scoring_uri         = "https://myendpoint.azureml.net/score"
  auth_mode           = "Key"
  properties          = {
    "property1": "valor1"
    "property2": "valor2"
  }
}

# Crie um recurso de grupo
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westus2"
}

# Crie um recurso de conta de armazenamento
resource "azurerm_storage_account" "example" {
  name                     = "example-storage"
  resource_group_name     = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Crie um recurso de Application Insights
resource "azurerm_application_insights" "example" {
  name                = "example-insights"
  resource_group_name = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  application_type     = "web"
}

# Crie um recurso de Key Vault
resource "azurerm_key_vault" "example" {
  name                = "example-vault"
  resource_group_name = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  sku_name            = "standard"
}

    