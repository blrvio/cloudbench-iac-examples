
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud API Key
  api_key = "YOUR_API_KEY"
  # Replace with your IBM Cloud region
  region  = "us-south"
}

# Create a Data Transfer Service Instance
resource "ibm_data_transfer_service_instance" "main" {
  name       = "my-data-transfer-service"
  location   = "us-south"
  plan       = "standard"
  service    = "data-transfer-service"
  resource_group = "my-resource-group"
}

# Create a Data Transfer Service Job
resource "ibm_data_transfer_service_job" "main" {
  instance_id = ibm_data_transfer_service_instance.main.id
  name        = "my-data-transfer-job"
  description = "Transfer data from source to destination"
  source {
    type   = "s3"
    # Replace with your source bucket
    bucket = "my-source-bucket"
    # Replace with your source region
    region = "us-east-1"
    access_key = "YOUR_ACCESS_KEY"
    secret_key = "YOUR_SECRET_KEY"
  }
  destination {
    type   = "s3"
    # Replace with your destination bucket
    bucket = "my-destination-bucket"
    # Replace with your destination region
    region = "us-west-2"
    access_key = "YOUR_ACCESS_KEY"
    secret_key = "YOUR_SECRET_KEY"
  }
}

  