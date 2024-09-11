
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Configure the region and tenancy OCID
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaa"
}

# Create a new Oracle Cloud Shell session
resource "oci_core_instance" "main" {
  availability_domain = "AD-1"
  compartment_id        = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaa"
  # Set the shape of the instance
  shape = "VM.Standard.E2.1"
  # Set the OS image to use
  source_details {
    source_type = "image"
    source_id  = "ocid1.image.oc1..aaaaaaaaaaaaaaaaaaaaaaaa"
  }
}

# Create a new SSH key pair
resource "oci_identity_key_pair" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaa"
  key_name      = "my-ssh-key"
  # You can optionally provide a public key here
  # public_key    = "ssh-rsa AAAAB3Nz..."
}

  