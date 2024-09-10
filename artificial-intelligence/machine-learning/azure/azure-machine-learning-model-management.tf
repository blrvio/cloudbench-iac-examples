
    # Configure the Azure Provider
provider "azurerm" {
  features {} # This is required for the latest Azure provider features.
}

# Create an Azure Machine Learning workspace
resource "azurerm_machine_learning_workspace" "main" {
  name                = "my-workspace"
  resource_group_name = "my-resource-group"
  location            = "eastus"
  # Set storage account configuration
  storage_account {
    name = "my-storage-account"
    sku  = "Standard_LRS"
  }
  # Set key vault configuration
  key_vault {
    name = "my-key-vault"
  }
}

# Create an Azure Machine Learning model
resource "azurerm_machine_learning_model" "main" {
  name                = "my-model"
  workspace_id        = azurerm_machine_learning_workspace.main.id
  description         = "My first ML model"
  # Set model properties
  properties {
    model_framework = "TensorFlow"
    model_type       = "Classification"
  }
  # Set model container image
  image {
    docker_image = "mcr.microsoft.com/azureml/openmpi3.1.6-ubuntu18.04"
    image_tag    = "latest"
  }
}

# Create an Azure Machine Learning model deployment
resource "azurerm_machine_learning_model_deployment" "main" {
  name                = "my-deployment"
  workspace_id        = azurerm_machine_learning_workspace.main.id
  model_id            = azurerm_machine_learning_model.main.id
  endpoint_name       = "my-endpoint"
  # Set deployment properties
  properties {
    # Define deployment configuration
    deployment_config {
      deployment_type = "Batch"
      # Define the compute target for the deployment
      compute_target {
        type = "AzureMLCompute"
        # Set the compute target name
        name = "my-compute-target"
      }
    }
  }
}

  