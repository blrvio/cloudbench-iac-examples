
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "your_ibm_cloud_api_key"
}

# Create an IAM service ID
resource "ibm_iam_service_id" "main" {
  name = "my-service-id"
  # Optional: Set the description
  description = "Service ID for my application"
}

# Create an IAM API key
resource "ibm_iam_api_key" "main" {
  service_id = ibm_iam_service_id.main.id
  # Optional: Set the description
  description = "API key for my application"
}

# Output the API key
output "api_key" {
  value = ibm_iam_api_key.main.api_key
}
  