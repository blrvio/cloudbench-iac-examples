
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  # Replace with your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your user OCID
  user_ocid    = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your region
  region       = "us-ashburn-1"
  # Replace with your API key
  api_key     = "your_api_key"
}

# Create a dedicated VM host
resource "oci_core_dedicated_vm_host" "example" {
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your availability domain
  availability_domain = "U1"
  # Replace with your shape
  shape = "VM.Standard.E2.1"
  # Replace with the name of the dedicated VM host
  display_name = "my-dedicated-vm-host"
}

# Create a VM instance on the dedicated VM host
resource "oci_core_instance" "example" {
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your availability domain
  availability_domain = "U1"
  # Replace with your shape
  shape = "VM.Standard.E2.1"
  # Replace with the name of the VM instance
  display_name = "my-vm-instance"
  # Replace with your subnet OCID
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Set the dedicated VM host to the VM instance
  dedicated_vm_host_id = oci_core_dedicated_vm_host.example.id
}

  