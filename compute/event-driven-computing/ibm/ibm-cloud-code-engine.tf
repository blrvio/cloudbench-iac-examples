
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create a Code Engine project
resource "ibm_codeengine_project" "main" {
  name    = "my-codeengine-project"
  location = "us-south"
}

# Create a Code Engine service
resource "ibm_codeengine_service" "main" {
  name = "my-codeengine-service"
  project_id = ibm_codeengine_project.main.id
  runtime = "nodejs-16"
  # Define the container image to use
  image = "us-docker.pkg.dev/cloud/containerregistry/nodejs-sample"
  # Define the port for the service
  port = 3000
}

  