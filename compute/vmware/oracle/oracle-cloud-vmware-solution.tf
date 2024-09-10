
    # Configure the Oracle Cloud provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaax43i74c7g26m45y3557g45454536454"
  user    = "ocid1.user.oc1..aaaaaaaax43i74c7g26m45y3557g45454536454"
  key     = "your_api_key"
  fingerprint = "your_api_key_fingerprint"
}

# Create a VCN
resource "oci_core_vcn" "main" {
  cidr_block      = "10.0.0.0/16"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaax43i74c7g26m45y3557g45454536454"
  display_name    = "my-vcn"
}

# Create a subnet
resource "oci_core_subnet" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaax43i74c7g26m45y3557g45454536454"
  vcn_id        = oci_core_vcn.main.id
  cidr_block      = "10.0.1.0/24"
  display_name    = "my-subnet"
}

# Create a VMware Instance
resource "oci_vmware_instance" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaax43i74c7g26m45y3557g45454536454"
  display_name    = "my-vmware-instance"
  subnet_id       = oci_core_subnet.main.id
  # Specify the image ID
  source_image_id = "ocid1.image.oc1..aaaaaaaax43i74c7g26m45y3557g45454536454"
  # Define the VM properties
  # ...
}

  