
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Habilite as funcionalidades desejadas
}

# Crie um recurso de Web PubSub
resource "azurerm_web_pubsub" "example" {
  name                = "example-webpubsub"
  location            = "westus2" # Substitua pela sua região desejada
  resource_group_name = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
  sku                 = "Free"
}

# Crie um endpoint de Web PubSub
resource "azurerm_web_pubsub_endpoint" "example" {
  name                = "example-endpoint"
  web_pubsub_name     = azurerm_web_pubsub.example.name
  resource_group_name = azurerm_web_pubsub.example.resource_group_name
  location            = azurerm_web_pubsub.example.location
}

    