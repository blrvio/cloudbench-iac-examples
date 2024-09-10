
    # Configure the IBM Cloud Provider
provider "ibm" {
  api_key = "YOUR_IBM_API_KEY" # Replace with your IBM Cloud API key
  region  = "us-south"
}

# Create a Watson Studio project
resource "ibm_watson_studio_project" "main" {
  name        = "my-watson-studio-project"
  description = "My Watson Studio Project"
}

# Create a Watson Studio Notebook
resource "ibm_watson_studio_notebook" "main" {
  project_id = ibm_watson_studio_project.main.id
  name        = "my-notebook"
}

# Create a Watson Studio Deployment
resource "ibm_watson_studio_deployment" "main" {
  project_id = ibm_watson_studio_project.main.id
  name        = "my-deployment"
  runtime     = "python-3.6"
  code        = <<EOF
print("Hello from Watson Studio!")
EOF
}

  