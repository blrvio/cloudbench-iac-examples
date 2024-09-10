
    # Configure the IBM Cloud Provider
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
  # You can optionally provide other provider configuration values here
}

# Create a Schematics workflow
resource "ibm_schematics_workflow" "main" {
  name     = "My-Schematics-Workflow"
  template = "github.com/ibm-cloud/schematics-templates/workflows/example/schematics-example-workflow.yaml"
  # You can provide other workflow configuration options here
}

  