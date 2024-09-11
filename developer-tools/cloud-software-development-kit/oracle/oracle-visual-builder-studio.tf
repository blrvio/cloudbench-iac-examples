
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Set the region and tenancy OCID
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxx"
}

# Create a Visual Builder Studio workspace
resource "oci_visual_builder_studio_workspace" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxx"
  display_name = "my-visual-builder-studio-workspace"
}

# Create a Visual Builder Studio application
resource "oci_visual_builder_studio_application" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxx"
  display_name  = "my-visual-builder-studio-application"
  workspace_id  = oci_visual_builder_studio_workspace.main.id
}

# Create a Visual Builder Studio project
resource "oci_visual_builder_studio_project" "main" {
  application_id = oci_visual_builder_studio_application.main.id
  display_name   = "my-visual-builder-studio-project"
  # Define the project type, e.g., 'WEB' or 'MOBILE'
  project_type = "WEB"
}

  