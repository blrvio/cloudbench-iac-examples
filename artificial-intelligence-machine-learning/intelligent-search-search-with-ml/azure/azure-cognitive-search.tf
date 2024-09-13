
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Ativa recursos de pré-lançamento
}

# Crie um recurso de pesquisa cognitiva
resource "azurerm_search_service" "search" {
  name                = "mysearchservice"
  location            = "westus2"
  resource_group_name = "myresourcegroup"
  sku {
    name     = "free"
    tier     = "free"
  }
}

# Crie um índice de pesquisa
resource "azurerm_search_index" "index" {
  name                = "myindex"
  search_service_name = azurerm_search_service.search.name
  resource_group_name = azurerm_search_service.search.resource_group_name
  fields {
    name  = "title"
    type  = "Edm.String"
    facet = true
  }
  fields {
    name  = "description"
    type  = "Edm.String"
    facet = true
  }
}
    