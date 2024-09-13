
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Ative os recursos mais recentes
}

# Crie um hub IoT
resource "azurerm_iot_hub" "example" {
  name                = "example-hub"
  location            = "westus2"
  resource_group_name = "example-resources"
  sku                  = "S1"

  tags = {
    environment = "production"
  }
}

# Crie um dispositivo IoT
resource "azurerm_iot_hub_device" "example" {
  name                = "example-device"
  iot_hub_name        = azurerm_iot_hub.example.name
  resource_group_name = "example-resources"
}

# Crie uma regra de encaminhamento para o hub IoT
resource "azurerm_iot_hub_route" "example" {
  name                = "example-route"
  iot_hub_name        = azurerm_iot_hub.example.name
  resource_group_name = "example-resources"

  source          = "DeviceMessages"
  endpoint        = "EventHubs"
  endpoint_name  = "example-eventhub"
  condition        = "true"
  ttl             = 7200

  // ... outras configurações de encaminhamento ...
}

# ... mais recursos do Azure IoT Platform ...

    