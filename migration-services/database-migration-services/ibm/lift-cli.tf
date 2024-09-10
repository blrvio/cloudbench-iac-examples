
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region = "us-south"
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a Lift CLI project
resource "ibm_lift_project" "main" {
  name = "my-lift-project"
  description = "Example Lift CLI project"
}

# Deploy a Lift CLI application
resource "ibm_lift_deployment" "main" {
  project_id = ibm_lift_project.main.id
  name = "my-lift-app"
  manifest_file = "manifest.yaml"
  # Set the branch to deploy, default is 'main'
  branch = "main"
}

  