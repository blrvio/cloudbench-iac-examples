
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
}

# Crie uma organização Apigee
resource "google_apigee_organization" "default" {
  name = "your-organization-name"
}

# Crie um ambiente Apigee
resource "google_apigee_environment" "default" {
  name     = "your-environment-name"
  org_id   = google_apigee_organization.default.id
  location = "us-central1"
}

# Crie uma API Proxy
resource "google_apigee_apiproxy" "default" {
  name     = "your-api-proxy-name"
  revision = "1"
  org_id   = google_apigee_organization.default.id
  env_id   = google_apigee_environment.default.id
  
  proxy_endpoints {
    name = "default"
    # ...
  }
}

# Crie um endpoint de backend
resource "google_apigee_backend" "default" {
  name     = "your-backend-name"
  org_id   = google_apigee_organization.default.id
  env_id   = google_apigee_environment.default.id
  
  endpoint_properties {
    # ...
  }
}
    