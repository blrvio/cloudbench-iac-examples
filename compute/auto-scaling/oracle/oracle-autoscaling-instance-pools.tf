
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your tenancy OCID
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your API Key
  api_key_file = "~/.oci/config"
}

# Create an Instance Pool
resource "oci_core_instance_pool" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with a valid instance configuration
  instance_configuration_id = "ocid1.instanceconfiguration.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name = "example-instance-pool"
  # Optional: Set the size of the pool
  size = 10
}

# Create a Launch Configuration
resource "oci_core_instance_configuration" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name = "example-launch-configuration"
  # Replace with a valid instance shape
  shape = "VM.Standard.E2.1"
  # Replace with a valid image OCID
  source_details {
    image_id = "ocid1.image.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  }
  # Optional: Set the subnet ID
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

  