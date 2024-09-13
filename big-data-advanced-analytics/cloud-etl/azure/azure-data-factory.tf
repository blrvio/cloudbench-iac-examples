
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Certifique-se de que a versão mais recente do provedor está sendo utilizada
}

# Crie um espaço de trabalho do Data Factory
resource "azurerm_data_factory" "example" {
  name     = "example-data-factory"
  location = "westus2"
  resource_group_name = "example-resource-group"
}

# Crie um pipeline de dados
resource "azurerm_data_factory_pipeline" "example" {
  name             = "example-pipeline"
  data_factory_id = azurerm_data_factory.example.id

  activities {
    name     = "example-copy-activity"
    type     = "Copy"
    inputs {
      name = "example-input-dataset"
    }
    outputs {
      name = "example-output-dataset"
    }
  }
}

# Crie um conjunto de dados de entrada
resource "azurerm_data_factory_dataset" "example_input_dataset" {
  name     = "example-input-dataset"
  type     = "DelimitedText"
  linked_service_name = "example-linked-service"
  data_factory_id = azurerm_data_factory.example.id
}

# Crie um conjunto de dados de saída
resource "azurerm_data_factory_dataset" "example_output_dataset" {
  name     = "example-output-dataset"
  type     = "DelimitedText"
  linked_service_name = "example-linked-service"
  data_factory_id = azurerm_data_factory.example.id
}

# Crie um serviço vinculado
resource "azurerm_data_factory_linked_service" "example" {
  name     = "example-linked-service"
  type     = "AzureBlobStorage"
  data_factory_id = azurerm_data_factory.example.id
  connection_string = "DefaultEndpointsProtocol=https;AccountName=example-storage-account;AccountKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  # ... outros parâmetros necessários
}

    