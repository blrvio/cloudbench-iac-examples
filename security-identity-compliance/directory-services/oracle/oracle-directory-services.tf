
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your desired region
  # Authenticate using an API key and secret
  # You can use the OCI CLI to generate an API key
  # Refer to: https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/gettingstarted.htm
  api_key_file = "~/.oci/config" # Path to your OCI config file
}

# Create an Oracle Directory Service Instance
resource "oci_identity_instance" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaab78p063g777777777777777777" # Replace with your compartment ID
  display_name = "example-directory-service"
  # Define the network configuration
  network_config {
    # Use an existing subnet for your instance
    subnet_id = "ocid1.subnet.oc1..aaaaaaaab78p063g777777777777777777" # Replace with your subnet ID
  }
  # Define the security configuration
  security_config {
    # Use an existing VCN for your instance
    vcn_id = "ocid1.vcn.oc1..aaaaaaaab78p063g777777777777777777" # Replace with your VCN ID
  }
}

# Create an Oracle Directory Service User
resource "oci_identity_user" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaab78p063g777777777777777777" # Replace with your compartment ID
  display_name = "example-user"
  # Define the user's password
  password = "password123"
  # Associate the user with the Directory Service instance
  instance_id = oci_identity_instance.example.id
}

  