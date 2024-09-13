
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Configurações adicionais do provedor
}

# Crie um recurso de Data Box
resource "azurerm_data_box_disk_transfer" "example" {
  name                = "example-databox"
  location            = "westus"
  resource_group_name = "example-resources"
  account_name        = "example-storage"
  transfer_type      = "Import"
  
  # Suporte a longas strings
  #  storage_account_key = "[your storage account key]" 
}

# Crie um recurso de Data Box Edge
resource "azurerm_data_box_edge_device" "example" {
  name               = "example-databoxedge"
  resource_group_name = "example-resources"
  location            = "westus"
  sku                 = "Edge"
}

# Crie um recurso de Data Box Gateway
resource "azurerm_data_box_gateway" "example" {
  name               = "example-databoxgateway"
  resource_group_name = "example-resources"
  location            = "westus"
  sku                 = "Standard"
}

    