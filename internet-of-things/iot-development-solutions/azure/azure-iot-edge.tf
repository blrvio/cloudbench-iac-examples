
      # Configure o provedor Azure
provider "azurerm" {
  features {} # Ensure you are using the latest version of the provider
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "westus2"
}

# Crie um dispositivo IoT Edge
resource "azurerm_iot_edge_device" "example" {
  name                = "myIotEdgeDevice"
  resource_group_name = azurerm_resource_group.example.name
  iot_hub_name      = "myIotHub"
}

# Crie um módulo IoT Edge
resource "azurerm_iot_edge_module" "example" {
  name                = "myModule"
  resource_group_name = azurerm_resource_group.example.name
  iot_hub_name      = "myIotHub"
  device_id          = azurerm_iot_edge_device.example.id
}

# Crie uma configuração de módulo IoT Edge
resource "azurerm_iot_edge_module_configuration" "example" {
  name                = "myModuleConfiguration"
  resource_group_name = azurerm_resource_group.example.name
  iot_hub_name      = "myIotHub"
  device_id          = azurerm_iot_edge_device.example.id
  modules             = [{"name": "myModule", "version": "1.0", "type": "docker", "settings": {"image": "mcr.microsoft.com/azureiotedge-samples/temperature-sensor:latest"}}]
}

    