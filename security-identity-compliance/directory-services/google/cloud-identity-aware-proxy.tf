
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Replace with your desired region
}

# Create an Identity-Aware Proxy (IAP) client
resource "google_iap_client" "default" {
  name     = "my-iap-client"
  display_name = "My IAP Client"
  project = "your-gcp-project-id"
}

# Create an IAP setting
resource "google_iap_settings" "default" {
  name     = "my-iap-setting"
  project = "your-gcp-project-id"
  
  # Optional settings
  #  oauth_client_id = "your-oauth-client-id"
  #  oauth_client_secret = "your-oauth-client-secret"
  #  enabled = false # Disable IAP settings
  #  authentication_provider = "google_account" # Use Google Account Authentication
  #  authentication_provider = "idp_client_id" # Use Identity Provider Client ID
  #  oidc_audience = "your-oidc-audience"
  #  oidc_client_id = "your-oidc-client-id"
}

# Create an IAP web service
resource "google_iap_web" "default" {
  name     = "my-iap-web-service"
  project = "your-gcp-project-id"
  # URL of the backend service
  backend_url = "https://your-backend-service.example.com"
  #  iap_settings = google_iap_settings.default.name
  #  iap_client = google_iap_client.default.name
}

  