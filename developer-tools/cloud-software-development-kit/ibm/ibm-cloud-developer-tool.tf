
    # Configure the IBM Cloud Provider
provider "ibm" {
  # Replace with your IBM Cloud API Key
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  # Replace with your IBM Cloud Region
  region = "us-south"
}

# Create an IBM Cloud Code Engine Project
resource "ibm_codeengine_project" "main" {
  name = "my-codeengine-project"
  location = "us-south"
}

# Create an IBM Cloud Code Engine Application
resource "ibm_codeengine_application" "main" {
  name = "my-codeengine-app"
  project_id = ibm_codeengine_project.main.id
  runtime = "nodejs-18"
  # Replace with your application's source code repository
  git_url = "https://github.com/your-username/your-repo.git"
}

# Create an IBM Cloud Code Engine Service
resource "ibm_codeengine_service" "main" {
  name = "my-codeengine-service"
  project_id = ibm_codeengine_project.main.id
  application_name = ibm_codeengine_application.main.name
}

  