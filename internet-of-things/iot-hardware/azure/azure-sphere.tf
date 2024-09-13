
      /* Configure o provedor do Azure
provider "azurerm" {
  features {} # Omitendo para uma resposta concisa
}

# Crie um grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus2"
}

# Crie um dispositivo Azure Sphere
resource "azurerm_sphere_device" "example" {
  name                 = "example-device"
  resource_group_name  = azurerm_resource_group.example.name
  device_properties = {
    device_id      = "device-id"
    device_secret = "device-secret"
  }
}

# Crie um aplicativo Azure Sphere
resource "azurerm_sphere_application" "example" {
  name                 = "example-application"
  resource_group_name  = azurerm_resource_group.example.name
  application_properties = {
    application_id = "application-id"
    application_key = "application-key"
  }
}

# Crie um certificado Azure Sphere
resource "azurerm_sphere_certificate" "example" {
  name                 = "example-certificate"
  resource_group_name  = azurerm_resource_group.example.name
  certificate_properties = {
    certificate_data = "certificate-data"
  }
}*/
    