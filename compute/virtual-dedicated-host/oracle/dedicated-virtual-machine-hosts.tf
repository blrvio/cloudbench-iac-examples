
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region = "us-ashburn-1" # Replace with your desired region
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  fingerprint = "aaaaaaaaxxxxxx"
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Create a Dedicated VM Host
resource "oci_core_dedicated_vm_host" "main" {
  availability_domain = "Uocm:ME1"
  dedicated_vm_host_shape = "VM.Standard.E2.1"
  # Optionally set the name of the Dedicated VM Host
  display_name = "My Dedicated VM Host"
  # Configure the network settings
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaxxxxxx"
  # Define the tags for the dedicated VM Host
  defined_tags = {
    "Owner" = "Team A"
  }
  freeform_tags = {
    "Environment" = "Production"
  }
}

  