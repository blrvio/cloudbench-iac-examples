
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Ensure latest features are available
}

# Crie um recurso de Text Analytics
resource "azurerm_cognitive_services_account" "text_analytics" {
  name                = "text-analytics-resource"
  location            = "westus2" # Substitua pela região desejada
  resource_group_name = "resource-group-name" # Substitua pelo nome do grupo de recursos
  kind                = "TextAnalytics"
  sku {
    name = "F0"
  }
}

# Crie um endpoint para o recurso de Text Analytics
resource "azurerm_cognitive_services_account_endpoint" "text_analytics_endpoint" {
  name                = "text-analytics-endpoint"
  cognitive_services_account_id = azurerm_cognitive_services_account.text_analytics.id
  location            = "westus2" # Substitua pela região desejada
  resource_group_name = "resource-group-name" # Substitua pelo nome do grupo de recursos
}
    