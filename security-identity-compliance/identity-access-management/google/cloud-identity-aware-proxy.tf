
    # Configure the Google Cloud provider
provider "google" {
  project  = "gcp-project-id"
  region    = "us-central1" # Set the region to be used for resources
  zone     = "us-central1-a" # Set the zone to be used for resources
}

# Create a Cloud Identity-Aware Proxy service configuration
resource "google_iap_service" "default" {
  name    = "iap-service"
  project = "gcp-project-id"
  
  # Set the URL of the backend service to be protected by IAP
  backend_service = "backend-service-url"
}

# Create a Cloud Identity-Aware Proxy client configuration
resource "google_iap_client" "default" {
  name = "iap-client"
  
  # Set the application's client ID
  app_id = "your-app-client-id"
  
  # Set the application's client secret
  app_secret = "your-app-client-secret"
}

# Create a Cloud Identity-Aware Proxy client configuration
resource "google_iap_web" "default" {
  name     = "iap-web"
  project  = "gcp-project-id"
  service  = google_iap_service.default.name
  
  # Set the URL of the web application to be protected by IAP
  target_url = "https://your-webapp-url.com"
}

# Enable Cloud Identity-Aware Proxy for a specific backend service
#resource "google_iap_web" "default" {
#  name     = "iap-web"
#  project  = "gcp-project-id"
#  service  = "backend-service-url"
#  target_url = "https://your-webapp-url.com"
#}


  