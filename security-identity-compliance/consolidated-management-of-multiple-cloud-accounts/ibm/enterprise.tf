
    # Configure the IBM Cloud provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create an IBM Cloud service instance
resource "ibm_service_instance" "main" {
  name     = "my-service-instance"
  service  = "cloudant"
  plan     = "lite"
  location = "us-south"
}

# Create a Cloudant database
resource "ibm_cloudant_database" "main" {
  name     = "my-database"
  instance = ibm_service_instance.main.id
}
  