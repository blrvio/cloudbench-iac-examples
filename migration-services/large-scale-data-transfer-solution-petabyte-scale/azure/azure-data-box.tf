
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Adicione aqui recursos adicionais para o provedor
}

# Crie um recurso Data Box Disk
resource "azurerm_data_box_disk" "example" {
  name                 = "example-disk"
  resource_group_name  = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
  location             = "westus" # Substitua pela localização desejada
  transfer_type         = "Import"
  storage_account_type = "Standard_LRS" # Substitua pelo tipo de conta de armazenamento desejado
  size_in_tb           = "10" # Substitua pelo tamanho em TB desejado
  shipping_address {
    street_address_line1 = "123 Main St"
    city                 = "Anytown"
    state                 = "CA"
    postal_code           = "12345"
    country               = "US"
  }
}

# Crie um recurso Data Box Edge
resource "azurerm_data_box_edge" "example" {
  name                 = "example-edge"
  resource_group_name  = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
  location             = "westus" # Substitua pela localização desejada
  sku                  = "DataBoxEdgeGen2"
  shipping_address {
    street_address_line1 = "123 Main St"
    city                 = "Anytown"
    state                 = "CA"
    postal_code           = "12345"
    country               = "US"
  }
}

# Crie um recurso Data Box Gateway
resource "azurerm_data_box_gateway" "example" {
  name                 = "example-gateway"
  resource_group_name  = "example-resource-group" # Substitua pelo nome do seu grupo de recursos
  location             = "westus" # Substitua pela localização desejada
  sku                  = "DataBoxGatewayGen2"
  shipping_address {
    street_address_line1 = "123 Main St"
    city                 = "Anytown"
    state                 = "CA"
    postal_code           = "12345"
    country               = "US"
  }
}
    