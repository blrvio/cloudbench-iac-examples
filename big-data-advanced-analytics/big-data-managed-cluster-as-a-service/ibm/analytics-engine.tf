
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud API key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  # Replace with your IBM Cloud region
  region  = "us-south"
}

# Create an Analytics Engine instance
resource "ibm_analytics_engine_instance" "main" {
  # Replace with your Analytics Engine instance name
  name        = "my-analytics-engine-instance"
  # Replace with your Analytics Engine instance plan
  plan        = "starter"
  # Replace with your Analytics Engine instance location
  location    = "us-south"
  # Optionally, you can specify the service instance ID if you already have one
  service_instance_id = "YOUR_SERVICE_INSTANCE_ID"
}

  