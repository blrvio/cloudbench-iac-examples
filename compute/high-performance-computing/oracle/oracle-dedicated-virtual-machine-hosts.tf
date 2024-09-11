
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxx"
  user    = "ocid1.user.oc1..aaaaaaaaxxxxxxxxxx"
  key     = "your_api_key"
}

# Create a Dedicated Virtual Machine Host
resource "oci_core_dedicated_vm_host" "example" {
  availability_domain = "AD-1"
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxx"
  shape              = "VM.Standard.E2.2"
  # You can configure additional options here.
}

  