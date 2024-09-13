
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Para habilitar as funcionalidades mais recentes
}

# Crie um cluster HDInsight
resource "azurerm_hdinsight_cluster" "example" {
  name                = "hdinsightcluster"
  resource_group_name = "example-resources"
  location            = "westus2"

  cluster_properties {
    cluster_version = "4.0"
    storage_accounts = ["storage-account-name"] # Substitua pelo nome da conta de armazenamento
    http_password      = "password" # Substitua pela senha HTTP
  }

  # Crie um grupo de recursos
  resource "azurerm_resource_group" "example" {
    name     = "example-resources"
    location = "westus2"
  }

  # Crie uma conta de armazenamento
  resource "azurerm_storage_account" "example" {
    name                     = "storage-account-name"
    resource_group_name = "example-resources"
    location                 = "westus2"
    account_tier           = "Standard"
    account_replication_type = "LRS"
  }
}

    