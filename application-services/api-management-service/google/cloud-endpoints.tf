
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Endpoint service
resource "google_endpoints_service" "default" {
  name  = "my-cloud-endpoints-service"
  config {
    api_version = "v1"
    title       = "My Cloud Endpoints API"
  }
  disable_authentication = false
  disable_authorization = false
}

# Create a Cloud Endpoint service configuration
resource "google_endpoints_service_config" "default" {
  service_name = google_endpoints_service.default.name
  config {
    http {
      rules {
        selector      = "GET:/echo"
        allowed_methods = ["GET"]
      }
    }
  }
}

# Deploy the Cloud Endpoint service configuration
resource "google_endpoints_service_deployment" "default" {
  service_name = google_endpoints_service.default.name
  config_id    = google_endpoints_service_config.default.config_id
}

  