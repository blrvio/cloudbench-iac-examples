
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxx"
  user_ocid  = "ocid1.user.oc1..aaaaaaaaxxxxxxxxx"
  fingerprint = "xxxxxxxxxxxxxxxx"
  # Use a private key file
  key_file = "~/.oci/config/oci_api_key.pem"
}

# Create a compartment
resource "oci_core_compartment" "example" {
  compartment_id = oci_identity_compartment.example.id
  name          = "my-compartment"
  description    = "My compartment"
}

# Create a security list
resource "oci_network_security_list" "example" {
  compartment_id  = oci_core_compartment.example.id
  display_name    = "My Security List"
  egress_security_rules {
    description     = "Allow all egress traffic"
    protocol       = "all"
    direction       = "egress"
    is_stateless   = true
    source_type    = "cidr_block"
    source_address = "0.0.0.0/0"
  }
}

# Create a subnet
resource "oci_core_subnet" "example" {
  compartment_id   = oci_core_compartment.example.id
  display_name     = "My Subnet"
  vcn_id           = oci_core_vcn.example.id
  cidr_block       = "10.0.0.0/16"
  dns_label        = "my-subnet"
  prohibit_public_ip_on_vnic = false
  security_lists = [oci_network_security_list.example.id]
}

# Create a VCN
resource "oci_core_vcn" "example" {
  compartment_id = oci_core_compartment.example.id
  display_name   = "My VCN"
  cidr_block     = "10.0.0.0/16"
  dns_label       = "my-vcn"
}

# Create a compartment
resource "oci_identity_compartment" "example" {
  name = "my-compartment"
  description    = "My compartment"
}

  