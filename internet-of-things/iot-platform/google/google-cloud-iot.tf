
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo ID do seu projeto
  region  = "us-central1" # Substitua pela região desejada
}

# Crie um registro de dispositivo
resource "google_iot_device_registry" "registry" {
  name = "my-device-registry"
  region = "us-central1"
}

# Crie um dispositivo
resource "google_iot_device" "device" {
  device_id      = "my-device"
  device_registry = google_iot_device_registry.registry.name
  region          = "us-central1"
}

# Crie um dispositivo para receber dados
resource "google_iot_device_config" "device_config" {
  device_id      = "my-device"
  device_registry = google_iot_device_registry.registry.name
  region          = "us-central1"
  binary_data     = "base64:your-configuration-data" # Substitua pelos seus dados de configuração
}

# Publique dados para o dispositivo
resource "google_iot_device_state" "device_state" {
  device_id      = "my-device"
  device_registry = google_iot_device_registry.registry.name
  region          = "us-central1"
  binary_data     = "base64:your-data" # Substitua pelos seus dados
}
    