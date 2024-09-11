
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud Infrastructure tenancy OCID
  tenancy = "ocid1.tenancy.oc1..."
}

# Create a Visual Builder Studio instance
resource "oci_visualbuilder_studio_instance" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your desired instance name
  display_name   = "my-vbs-instance"
  # Define the version of Visual Builder Studio to use
  version        = "22.1.0"
}

# Create a Visual Builder Studio project
resource "oci_visualbuilder_studio_project" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your desired project name
  display_name   = "my-vbs-project"
  # Associate the project with the Visual Builder Studio instance
  instance_id = oci_visualbuilder_studio_instance.main.id
}

# Configure a Visual Builder Studio team
resource "oci_visualbuilder_studio_team" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  # Replace with your desired team name
  display_name   = "my-vbs-team"
  # Associate the team with the Visual Builder Studio instance
  instance_id = oci_visualbuilder_studio_instance.main.id
}

  