
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud IoT Core registry
resource "google_iot_registry" "default" {
  name     = "my-registry"
  location = "us-central1"
  event_notification_config {
    pubsub_topic_name = "projects/your-gcp-project-id/topics/my-topic"
  }
  http_config {
    http_enabled = false
  }
}

# Create a Cloud IoT Core device
resource "google_iot_device" "default" {
  registry_id = google_iot_registry.default.id
  name        = "my-device"
  auth_method {
    type  = "rsa_cert"
    value = "REPLACE_WITH_YOUR_RSA_CERT_VALUE"
  }
}

  