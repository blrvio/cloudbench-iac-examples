
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region = "us-south"
}

# Create an IBM Cloud service instance
resource "ibm_cloud_service_instance" "my_service" {
  name      = "my-service"
  plan      = "standard"
  service   = "cloudant"
  location = "us-south"
  tags      = {
    "Environment": "Development"
  }
}

# Get the service credentials
output "service_credentials" {
  value = ibm_cloud_service_instance.my_service.credentials
}
  