
    # Configure the Azure provider
provider "azurerm" {
  features {} # Enable all features
}

# Create an Azure Sphere Security Service
resource "azurerm_sphere_security_service" "example" {
  name                = "example-sphere-security-service"
  resource_group_name = "example-resource-group"
  location            = "westus2"
  # Optional configuration for IoT Hub
  iot_hub {
    # Use existing IoT Hub
    existing_iot_hub_name = "example-iot-hub"
    # Create a new IoT Hub
    # name                = "example-iot-hub"
    # location           = "westus2"
    # sku {
    #   name      = "F1"
    #   capacity = 1
    # }
    # partition           = "westus2"
  }
}

# Create an Azure Sphere Security Service Configuration
resource "azurerm_sphere_security_service_config" "example" {
  name                = "example-sphere-security-service-config"
  resource_group_name = "example-resource-group"
  location            = "westus2"
  security_service_id  = azurerm_sphere_security_service.example.id
}

# Create an Azure Sphere Security Service Update
resource "azurerm_sphere_security_service_update" "example" {
  name                = "example-sphere-security-service-update"
  resource_group_name = "example-resource-group"
  location            = "westus2"
  security_service_id  = azurerm_sphere_security_service.example.id
  # Optional parameters
  # security_service_config_id = azurerm_sphere_security_service_config.example.id
  # content_path                = "path/to/content"
}

  