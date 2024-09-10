
    # Configure the IBM Cloud provider
provider "ibm" {
  ibmcloud_api_key = "your_ibmcloud_api_key"
  region = "us-south"
}

# Create a Watson Query instance
resource "ibm_watson_query" "main" {
  name = "my-watson-query-instance"
  plan = "lite"
  # Additional settings can be added here as needed
  # ...
}

# Configure the Watson Query service
resource "ibm_watson_query_service" "main" {
  name = "my-watson-query-service"
  instance_id = ibm_watson_query.main.id
  # Additional settings can be added here as needed
  # ...
}
  