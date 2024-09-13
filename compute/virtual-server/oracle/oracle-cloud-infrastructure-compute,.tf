
      # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  user    = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

# Create a Compute Instance
resource "oci_core_instance" "example" {
  availability_domain = "AD-1"
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name        = "example-instance"
  shape               = "VM.Standard.E2.1"
  source_details {
    source_type = "image"
    image_id    = "ocid1.image.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  }
}

# Create a Virtual Network
resource "oci_core_virtual_network" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name    = "example-vnet"
  cidr_block      = "10.0.0.0/16"
}

# Create a Subnet
resource "oci_core_subnet" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name    = "example-subnet"
  virtual_network_id = oci_core_virtual_network.example.id
  cidr_block      = "10.0.1.0/24"
}

# Create a Security List
resource "oci_core_security_list" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name    = "example-security-list"
  egress {
    protocol = "all"
    source    = "0.0.0.0/0"
  }
  ingress {
    protocol = "tcp"
    source    = "0.0.0.0/0"
    port_range = "22"
  }
}

# Create a Network Security Group
resource "oci_core_network_security_group" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  display_name    = "example-nsg"
  security_list_ids = [oci_core_security_list.example.id]
}
    