
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Configure features for the provider
}

# Create a Redis Cache
resource "azurerm_redis_cache" "example" {
  name                 = "example-redis-cache"
  location             = "westus2"
  resource_group_name  = "example-resources"
  sku_name             = "Basic"
  capacity             = 1
  # Enable the Redis Cache
  enable_non_ssl_port = false
}

  