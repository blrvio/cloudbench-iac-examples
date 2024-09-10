
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Cloud Shell instance
resource "ibm_cloud_shell" "main" {
  name = "my-cloud-shell"
}

  