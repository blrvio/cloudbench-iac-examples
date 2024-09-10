
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Code Engine project
resource "ibm_codeengine_project" "main" {
  name = "my-codeengine-project"
  location = "us-south"
  runtime = "nodejs-16"
}

# Create a Code Engine application
resource "ibm_codeengine_application" "main" {
  name = "my-codeengine-app"
  project_id = ibm_codeengine_project.main.id
  runtime = "nodejs-16"
  image = "us-docker.pkg.dev/cloudrun/container/hello"
  memory = 512
  cpu = 1
}

# Create a Code Engine service
resource "ibm_codeengine_service" "main" {
  name = "my-codeengine-service"
  project_id = ibm_codeengine_project.main.id
  application_name = ibm_codeengine_application.main.name
  routing_rules = [
    {
      path = "/"
      application_instance = "my-codeengine-app"
    }
  ]
}

  