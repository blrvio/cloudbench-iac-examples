
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Provide your tenancy OCID, user OCID, and private key
  tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaaz7g7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454"
  user_ocid        = "ocid1.user.oc1..aaaaaaaaz7g7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454"
  private_key_path = "~/.oci/oci_api_key.pem"
  region           = "us-ashburn-1"
}

# Create a Compute Instance
resource "oci_core_instance" "main" {
  availability_domain = "us-ashburn-1a"
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaaz7g7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454"
  display_name       = "my-instance"
  shape              = "VM.Standard.E2.1"
  source_details {
    source_type = "image"
    image_id   = "ocid1.image.oc1.us-ashburn-1.aaaaaaaa60j3w7s22q3q47u7r6q4256l5g42v5a26k57o6e3z2777p72t"
  }
}

# Create a Network Security Group
resource "oci_network_security_group" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7g7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454"
  display_name   = "my-nsg"
  egress {
    source_type = "CIDR_BLOCK"
    destination    = "0.0.0.0/0"
    protocol       = "all"
  }
  ingress {
    source_type = "CIDR_BLOCK"
    source       = "0.0.0.0/0"
    protocol     = "tcp"
    destination   = 22
  }
}

# Create a Virtual Network (VCN)
resource "oci_core_vcn" "main" {
  cidr_block      = "10.0.0.0/16"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7g7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454"
  display_name   = "my-vcn"
}

# Create a Subnet within the VCN
resource "oci_core_subnet" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7g7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454"
  display_name   = "my-subnet"
  vcn_id         = oci_core_vcn.main.id
  cidr_block      = "10.0.1.0/24"
}

# Attach the Security Group to the Instance
resource "oci_core_instance_network_interface" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7g7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454g7q7q5rk7g4k3g5h454"
  instance_id    = oci_core_instance.main.id
  subnet_id      = oci_core_subnet.main.id
  # Specify the Security Group
  security_lists = [oci_network_security_group.main.id]
}

  