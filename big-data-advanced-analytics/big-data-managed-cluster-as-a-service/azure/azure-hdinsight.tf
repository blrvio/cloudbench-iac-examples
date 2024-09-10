
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all AzureRM provider features
}

# Create a new Azure HDInsight cluster
resource "azurerm_hdinsight_cluster" "main" {
  name                 = "my-hdinsight-cluster"
  location              = "westus2"
  resource_group_name   = "my-resource-group"
  cluster_version      = "3.6"
  tier                 = "Standard"
  storage_account_name = "mystorageaccount"
  storage_account_key  = "mystoragekey" # You will need to replace this with your actual storage account key
  # Configure the HDInsight cluster with the desired worker nodes
  worker_nodes {
    node_count = 3
    vm_size     = "Standard_D2_v2"
  }
  # Configure the cluster with the desired head nodes
  head_node {
    vm_size = "Standard_D2_v2"
  }
}

# Create a new Azure Storage Account
resource "azurerm_storage_account" "main" {
  name                     = "mystorageaccount"
  resource_group_name        = "my-resource-group"
  location                  = "westus2"
  account_tier              = "Standard"
  account_replication_type = "LRS"
  # You can configure the storage account with additional options, such as enabling Azure Active Directory integration
  # Azure Active Directory integration is not necessary for HDInsight to work
}

# Create a new Azure Resource Group
resource "azurerm_resource_group" "main" {
  name     = "my-resource-group"
  location = "westus2"
}
  