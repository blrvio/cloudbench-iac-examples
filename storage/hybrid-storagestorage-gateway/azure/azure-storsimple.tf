
      # Configure o provedor do Azure
provider "azurerm" {
  features {} # Ativar recursos pré-lançados
}

# Crie um recurso StorSimple Device Manager
resource "azurerm_storsimple_device_manager" "example" {
  name     = "storsimple-device-manager"
  resource_group_name = "my-resource-group"
  location = "westus"
}

# Crie um dispositivo StorSimple
resource "azurerm_storsimple_device" "example" {
  name     = "my-storsimple-device"
  resource_group_name = "my-resource-group"
  device_manager_name  = azurerm_storsimple_device_manager.example.name
  location = "westus"
}

# Crie um volume StorSimple
resource "azurerm_storsimple_volume" "example" {
  name     = "my-storsimple-volume"
  resource_group_name = "my-resource-group"
  device_name  = azurerm_storsimple_device.example.name
  location = "westus"

  # Define a capacidade do volume
  capacity_in_gibibytes = 1024
}

    