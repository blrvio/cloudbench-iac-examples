
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Esta seção pode conter configurações específicas do provedor
}

# Crie um recurso de Media Services
resource "azurerm_media_services" "example" {
  name                = "example-media-services"
  location            = "westus2"
  resource_group_name = "example-resources"
  storage_account     = "example-storage"
  # ... outras configurações podem ser adicionadas aqui
}

# Crie um ponto final de Media Services
resource "azurerm_media_services_endpoint" "example" {
  name                = "example-endpoint"
  media_services_name = azurerm_media_services.example.name
  resource_group_name = "example-resources"
  # ... outras configurações podem ser adicionadas aqui
}

# Crie um conta de armazenamento para o Media Services
resource "azurerm_storage_account" "example" {
  name                     = "example-storage"
  resource_group_name       = "example-resources"
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # ... outras configurações podem ser adicionadas aqui
}

# Crie um CDN perfil para o Media Services
resource "azurerm_cdn_profile" "example" {
  name                = "example-cdn-profile"
  resource_group_name = "example-resources"
  location            = "westus2"
  sku                 = "Standard_Verizon"
  # ... outras configurações podem ser adicionadas aqui
}
    