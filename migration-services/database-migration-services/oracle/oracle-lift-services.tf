
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Configure the region
  region = "us-ashburn-1"
  # Set your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaz5h75q777666666666666666666666666"
  # Set your user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaz5h76q777666666666666666666666666"
  # Set your private key file
  # The path to the private key file used to authenticate to the Oracle Cloud Infrastructure service
  # Make sure you replace this with your actual private key file path
  # This is an example, you should set the actual path to your private key
  # Private keys are not a secret in the Terraform sense. You will have to provide the path to the file.
  # Note that private keys should be treated as secrets and must be handled with extreme care.
  private_key_file = "~/path/to/your/private/key/file"
}

# Create an Oracle Lift Services instance
resource "oci_lift_instance" "main" {
  # Specify the compartment OCID for the instance
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz5h76q777666666666666666666666666"
  # Specify the name of the Lift Services instance
  display_name = "my-lift-instance"
  # Specify the instance shape
  shape = "VM.Standard.A1.Flex"
  # Specify the availability domain
  availability_domain = "us-ashburn-1a"
  # Specify the operating system image
  os_image_id = "ocid1.image.oc1..aaaaaaaaz5h76q777666666666666666666666666"
  # Specify the network configuration
  # This should include the subnet OCID and the network security groups
  network_config {
    # Specify the subnet OCID
    subnet_id = "ocid1.subnet.oc1..aaaaaaaaz5h76q777666666666666666666666666"
    # Specify the network security group IDs
    nsg_ids = ["ocid1.nsg.oc1..aaaaaaaaz5h76q777666666666666666666666666"]
  }
}

  