
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Crie um registro de dispositivo
resource "google_iot_device" "device" {
  project = google_project.project.project_id
  region  = google_project.project.region
  device_id = "your-device-id"

  # Use o arquivo de chave pública do dispositivo para autenticação
  public_key {
    format = "PEM"
    key    = "-----BEGIN PUBLIC KEY-----
...
-----END PUBLIC KEY-----"
  }

  # Crie um registro de dispositivo no Cloud IoT Core
  registry_id = "your-registry-id"
}

# Crie um dispositivo no Cloud IoT Core
resource "google_iot_device" "device" {
  project = google_project.project.project_id
  region  = google_project.project.region
  device_id = "your-device-id"

  # Use o arquivo de chave pública do dispositivo para autenticação
  public_key {
    format = "PEM"
    key    = "-----BEGIN PUBLIC KEY-----
...
-----END PUBLIC KEY-----"
  }

  # Crie um registro de dispositivo no Cloud IoT Core
  registry_id = "your-registry-id"
}
    