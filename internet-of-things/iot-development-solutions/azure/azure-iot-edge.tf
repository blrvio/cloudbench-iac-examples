
    # Configure the Azure Provider
provider "azurerm" {
  features {} # Enable all AzureRM features
}

# Define the resource group
resource "azurerm_resource_group" "main" {
  name     = "my-iot-edge-resource-group"
  location = "westus2"
}

# Define the IoT Hub
resource "azurerm_iot_hub" "main" {
  name                = "my-iot-hub"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "S1"
  # Configure the IoT Edge Deployment
  deployment_config {
    max_device_count = 10
  }
}

# Define the IoT Edge Device
resource "azurerm_iot_edge_device" "main" {
  name                = "my-edge-device"
  resource_group_name = azurerm_resource_group.main.name
  iot_hub_name        = azurerm_iot_hub.main.name
  # Assign a device ID
  id                  = "my-device-id"
}

# Define the IoT Edge Module
resource "azurerm_iot_edge_module" "main" {
  name                = "my-edge-module"
  resource_group_name = azurerm_resource_group.main.name
  iot_hub_name        = azurerm_iot_hub.main.name
  # Define the image source for the module
  image              = "my-module-image:latest"
  # Configure module settings
  settings            = "{
    "key1": "value1",
    "key2": "value2"
  }"
}

# Deploy the module to the device
resource "azurerm_iot_edge_deployment" "main" {
  name                = "my-edge-deployment"
  resource_group_name = azurerm_resource_group.main.name
  iot_hub_name        = azurerm_iot_hub.main.name
  # Define the device and module to deploy
  device_id           = azurerm_iot_edge_device.main.id
  modules             = [
    {
      module_id = azurerm_iot_edge_module.main.name
      # Configure deployment settings
      settings = "{
        "key1": "value1",
        "key2": "value2"
      }"
    }
  ]
}

  