
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure IoT Hub
resource "azurerm_iot_hub" "main" {
  name                = "my-iot-hub"
  location            = "westus2"
  resource_group_name = "my-resource-group"
  sku {
    name = "S1"
  }
  partitioning {
    enabled = false
  }

  # Define the storage endpoints
  storage_endpoint {
    container_name = "events"
    auth_mode      = "keyBased"
    connection_string = "your_connection_string"
  }
}

# Create an Azure IoT Hub Device Identity
resource "azurerm_iot_hub_device_identity" "main" {
  name                 = "my-device"
  iot_hub_name        = azurerm_iot_hub.main.name
  resource_group_name = azurerm_iot_hub.main.resource_group_name
  # Assign a device ID
  device_id = "my-device-id"
}

# Create an Azure IoT Hub Endpoint
resource "azurerm_iot_hub_endpoint" "main" {
  name                 = "my-endpoint"
  iot_hub_name        = azurerm_iot_hub.main.name
  resource_group_name = azurerm_iot_hub.main.resource_group_name
  # Define the endpoint type
  endpoint_type = "ingress"
  # Add a new endpoint
  endpoint_uri = "your_endpoint_uri"
}

  