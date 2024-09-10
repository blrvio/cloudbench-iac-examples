
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  region  = "us-south"
}

# Create a Code Engine project
resource "ibm_codeengine_project" "main" {
  name = "my-codeengine-project"
  location = "us-south"
}

# Create a Code Engine application
resource "ibm_codeengine_application" "main" {
  name        = "my-codeengine-app"
  project_id  = ibm_codeengine_project.main.id
  runtime     = "nodejs-16"
  build_source {
    git {
      url  = "https://github.com/your-username/your-repo.git"
      branch = "main"
    }
  }
  # Configure the ingress
  ingress {
    enabled = true
  }
}

# Create a Code Engine service
resource "ibm_codeengine_service" "main" {
  name        = "my-codeengine-service"
  project_id  = ibm_codeengine_project.main.id
  application  = ibm_codeengine_application.main.name
  route        = "my-codeengine-service.us-south.codeengine.appdomain.cloud"
  # Define the service's resources
  resources {
    cpu     = "1"
    memory = "256Mi"
  }
}

  