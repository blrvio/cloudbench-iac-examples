
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enables all features, including preview features.
}

# Define the Blockchain Workbench Resource Group
resource "azurerm_resource_group" "blockchain_workbench_rg" {
  name     = "blockchain-workbench-rg"
  location = "westus2"
}

# Create a Blockchain Workbench instance
resource "azurerm_blockchain_workbench" "main" {
  name                 = "myblockchainworkbench"
  resource_group_name = azurerm_resource_group.blockchain_workbench_rg.name
  location             = azurerm_resource_group.blockchain_workbench_rg.location
  sku                  = "Standard"
  # This field can be used to customize the Blockchain Workbench instance
  # by deploying a custom application into the workspace. More details are available at
  # https://docs.microsoft.com/en-us/azure/blockchain/blockchain-workbench-create-instance
  # deployment_template  = "your-deployment-template.json"
  tags = {
    environment = "dev"
  }
}

  