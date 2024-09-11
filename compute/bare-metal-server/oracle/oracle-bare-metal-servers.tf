
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
}

# Create a bare metal server
resource "oci_core_instance" "main" {
  availability_domain = "AD-1"
  shape              = "BM.Standard.E2.1.X"
  compartment_id       = "ocid1.compartment.oc1..."
  # Define the SSH key that will be used to access the instance
  source_details {
    source_type = "PUBLIC_KEY"
    source_value = "ssh-rsa AAAAB3NzaC1yc2E..."
  }
  display_name = "My Bare Metal Server"
  network_interfaces {
    subnet_id = "ocid1.subnet.oc1..."
    private_ip = "172.16.0.10"
  }
}

  