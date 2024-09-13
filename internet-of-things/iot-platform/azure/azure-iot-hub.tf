
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Habilita recursos beta
}

# Crie um hub IoT
resource "azurerm_iot_hub" "example" {
  name                = "example-hub"
  location            = "westus2"
  resource_group_name = "example-resources"
  sku {
    name = "S1"
  }
  partition_count      = 2
  tags = {
    environment = "test"
  }
}

# Crie uma conexão de dispositivo IoT
resource "azurerm_iot_hub_device" "example" {
  name                 = "device-example"
  iot_hub_name        = azurerm_iot_hub.example.name
  resource_group_name = azurerm_iot_hub.example.resource_group_name
  authentication {
    type = "sas"
  }
}

# Crie uma regra de direcionamento para um hub IoT
resource "azurerm_iot_hub_route" "example" {
  name                 = "route-example"
  source               = "DeviceMessages"
  condition            = "true"
  endpoint_uri          = "sb://mynamespace.servicebus.windows.net/mytopic"
  iot_hub_name        = azurerm_iot_hub.example.name
  resource_group_name = azurerm_iot_hub.example.resource_group_name
  enabled              = true
}

# Crie uma chave compartilhada para um hub IoT
resource "azurerm_iot_hub_shared_access_policy" "example" {
  name                 = "example-policy"
  iot_hub_name        = azurerm_iot_hub.example.name
  resource_group_name = azurerm_iot_hub.example.resource_group_name
  permissions         = ["serviceConnect"]
}

# Obtenha a chave primária da chave compartilhada
output "example_policy_primary_key" {
  value = azurerm_iot_hub_shared_access_policy.example.primary_key
}
    