
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
    name     = "S1"
    capacity = 1
  }

  # Optional settings
  partition_count       = 2
  public_network_access = "Enabled"
}

# Create an IoT Hub Device
resource "azurerm_iot_hub_device" "main" {
  device_id        = "my-device"
  iot_hub_name     = azurerm_iot_hub.main.name
  connection_string = "HostName=my-iot-hub.azure-devices.net;DeviceId=my-device;SharedAccessKey=your-device-key"
  # Optional settings
  authentication {
    type = "sas"
  }
  # Define tags for the device
  tags = {
    Environment = "Production"
  }
}

  