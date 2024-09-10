
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API key
  region = "us-south"
}

# Create a Cloudant instance
resource "ibm_cloudant_instance" "main" {
  name  = "my-cloudant-instance" # Replace with your desired instance name
  plan  = "lite"
  region = "us-south"
}

# Create a Cloudant database
resource "ibm_cloudant_database" "main" {
  name    = "my-cloudant-database"
  instance = ibm_cloudant_instance.main.id
}
  