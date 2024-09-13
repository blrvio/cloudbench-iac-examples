
      # Configure o provedor IBM Cloud
provider "ibm" {
  api_key = "YOUR_IBM_API_KEY"
  region   = "us-south"
}

# Crie um projeto no Watson Studio
resource "ibm_watson_studio_project" "my_project" {
  name = "My Project"
  description = "My first Watson Studio project"
}

# Crie um espaço de trabalho no Watson Studio
resource "ibm_watson_studio_workspace" "my_workspace" {
  name = "My Workspace"
  project_id = ibm_watson_studio_project.my_project.id
}
    