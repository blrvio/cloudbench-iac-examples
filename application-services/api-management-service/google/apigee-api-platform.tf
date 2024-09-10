
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Change to your preferred region
}

# Create an Apigee organization
resource "google_apigee_organization" "main" {
  name = "my-apigee-org"
  display_name = "My Apigee Organization"
}

# Create an Apigee environment
resource "google_apigee_environment" "main" {
  name = "my-apigee-env"
  organization = google_apigee_organization.main.name
  display_name = "My Apigee Environment"
}

# Create an Apigee API Proxy
resource "google_apigee_apiproxy" "main" {
  name = "my-api-proxy"
  organization = google_apigee_organization.main.name
  environment = google_apigee_environment.main.name
  revision = 1
  proxy_endpoint = "my-api-proxy.com"
  # Define the base path for the API Proxy
  basepath = "/my-api"
  # Define the target endpoint for the API Proxy
  target_endpoint = "https://api.example.com/v1"
  # Define the API Proxy configuration
  apiproxy_configuration = <<EOF
  <ProxyEndpoint>
    <HTTPProxyConnection>
      <VirtualHost>
        <URL>https://api.example.com/v1</URL>
      </VirtualHost>
    </HTTPProxyConnection>
  </ProxyEndpoint>
EOF
  # Define the API Proxy deployment
  apiproxy_deployment {
    environment = google_apigee_environment.main.name
  }
}

  