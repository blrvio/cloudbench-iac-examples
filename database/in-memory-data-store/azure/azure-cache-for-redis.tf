
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Ativa todos os recursos do provedor
}

# Crie um cache Redis
resource "azurerm_redis_cache" "example" {
  name                 = "example-cache"
  location              = "westus2"
  resource_group_name = "example-resources"
  sku_name             = "Basic"
  capacity             = 1
}

# Crie uma chave de acesso para o cache
resource "azurerm_redis_cache_key" "example" {
  name                 = "example-key"
  resource_group_name = "example-resources"
  cache_name          = azurerm_redis_cache.example.name
}

# (Opcional) Exporte a chave de acesso
output "redis_access_key" {
  value = azurerm_redis_cache_key.example.value
}
    