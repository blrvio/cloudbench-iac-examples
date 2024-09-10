
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  account_id = "YOUR_IBM_CLOUD_ACCOUNT_ID"
  api_key    = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Code Engine project
resource "ibm_codeengine_project" "example" {
  name     = "my-codeengine-project"
  location = "us-south"
}

# Create a Code Engine application
resource "ibm_codeengine_application" "example" {
  name = "my-codeengine-app"
  project_id = ibm_codeengine_project.example.id
  runtime = "nodejs:16"
  # Create a deployment for the application
  deployment {
    image = "us-south.icr.io/my-namespace/my-image:latest"
  }
}

  