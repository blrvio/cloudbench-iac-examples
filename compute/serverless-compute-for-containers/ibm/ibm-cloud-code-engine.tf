
    # Configure the IBM Cloud Provider
provider "ibm-cloud" {
  api_key = "YOUR_API_KEY"
  region  = "us-south"
}

# Create a Code Engine Project
resource "ibm_codeengine_project" "main" {
  name     = "my-codeengine-project"
  location = "us-south"
}

# Create a Code Engine Application
resource "ibm_codeengine_application" "main" {
  name     = "my-codeengine-app"
  project  = ibm_codeengine_project.main.id
  location = "us-south"
  runtime  = "nodejs-18"
  build {
    source {
      git {
        url   = "https://github.com/your-username/your-repository.git"
        branch = "main"
      }
    }
  }
  # Define the desired number of replicas
  replicas = 1
  # Configure container ports
  container_ports = [8080]
  # Create a service to expose the application
  service {
    name     = "my-codeengine-service"
    ports    = [8080]
    protocol = "http"
    # Specify the desired route prefix
    route_prefix = "/app"
  }
}

  