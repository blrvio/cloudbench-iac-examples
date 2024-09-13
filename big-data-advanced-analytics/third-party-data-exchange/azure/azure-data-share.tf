
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Verifique se a versão mais recente está sendo usada
}

# Crie um recurso de compartilhamento de dados
resource "azurerm_data_share" "example" {
  name                = "example-data-share"
  location            = "westus2"
  resource_group_name = "example-resource-group"

  # Defina as fontes de dados para compartilhar
  source_share_details = {
    source_share_id = "example-source-share-id"
    share_kind       = "AzureSynapseAnalytics"
  }
}

# Crie um assinante para compartilhar dados
resource "azurerm_data_share_subscriber" "example" {
  name                = "example-subscriber"
  data_share_name     = azurerm_data_share.example.name
  resource_group_name = "example-resource-group"
  target_resource_id  = "example-target-resource-id"
  kind                 = "AzureSynapseAnalytics"
}

    