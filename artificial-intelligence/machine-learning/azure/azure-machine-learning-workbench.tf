
    # Configure the AzureRM Provider
provider "azurerm" {
  features {} 
  # Add your Azure credentials here
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "westus2"
}

# Create a machine learning workspace
resource "azurerm_machine_learning_workspace" "main" {
  name                = "my-workspace"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  # Additional configuration options can be added here
}

# Create an Azure Machine Learning Workbench instance
resource "azurerm_machine_learning_workbench" "main" {
  name                = "my-workbench"
  resource_group_name = azurerm_resource_group.main.name
  workspace_name      = azurerm_machine_learning_workspace.main.name
  location            = azurerm_resource_group.main.location
  # Additional configuration options can be added here
}

  