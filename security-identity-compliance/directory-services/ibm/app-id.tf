
    # Configure the IBM Cloud provider
provider "ibm" {
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY"
  region = "us-south"
}

# Create an App ID service
resource "ibm_appid_service" "main" {
  name = "my-app-id-service"
  # Specify the environment for the service
  environment = "staging"
  # Create an API key
  create_api_key = true
  # Add tags
  tags = {
    "tag-key-1" = "tag-value-1"
  }
}

# Configure an App ID client
resource "ibm_appid_client" "main" {
  service_id = ibm_appid_service.main.id
  name = "my-app-id-client"
  # Configure client type
  client_type = "application"
  # Configure client secret
  create_secret = true
  # Create a new client secret
  create_secret = true
}

  