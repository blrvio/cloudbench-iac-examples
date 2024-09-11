
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your region
  # Configure your credentials
  # You can find the necessary credentials in your Oracle Cloud Infrastructure account
  # Alternatively, use environment variables
  # OCI_CONFIG_FILE="~/.oci/config"
}

# Create a Visual Builder Studio workspace
resource "oci_visual_builder_studio_workspace" "main" {
  compartment_id  = "ocid1.compartment.oc1..aaaaaaaaw7o7b7d7"
  display_name = "My Workspace"
  # Optional settings
  # description      = "My Workspace Description"
  # is_managed_by_oci = false
  # location        = "us-ashburn-1"
}

# Create a Visual Builder Studio application
resource "oci_visual_builder_studio_application" "main" {
  compartment_id   = "ocid1.compartment.oc1..aaaaaaaaw7o7b7d7"
  workspace_id     = oci_visual_builder_studio_workspace.main.id
  display_name    = "My Application"
  # Optional settings
  # application_type = "MOBILE_APPLICATION"
  # description      = "My Application Description"
}

# Create a Visual Builder Studio project
resource "oci_visual_builder_studio_project" "main" {
  application_id = oci_visual_builder_studio_application.main.id
  display_name   = "My Project"
  # Optional settings
  # description     = "My Project Description"
  # is_managed_by_oci = false
  # project_type     = "MOBILE_APPLICATION"
}

  