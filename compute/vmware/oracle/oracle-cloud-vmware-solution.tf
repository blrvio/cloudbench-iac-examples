
    # Configure the Oracle Cloud Provider
provider "oci" {
  # Replace with your Oracle Cloud tenancy information
  tenancy = "ocid1.tenancy.oc1..."
  user = "ocid1.user.oc1..."
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  private_key = "~/.oci/oci_api_key.pem"
  region = "us-ashburn-1"
}

# Create a VCN (Virtual Cloud Network)
resource "oci_core_vcn" "main" {
  cidr_block = "10.0.0.0/16"
  display_name = "my-vcn"
  # Add any other relevant options here
}

# Create a Subnet
resource "oci_core_subnet" "main" {
  vcn_id = oci_core_vcn.main.id
  cidr_block = "10.0.1.0/24"
  display_name = "my-subnet"
  # Add any other relevant options here
}

# Create a Security List
resource "oci_core_security_list" "main" {
  vcn_id = oci_core_vcn.main.id
  display_name = "my-security-list"
  # Define the ingress rules
  ingress {
    protocol = "tcp"
    source_type = "cidr_block"
    source = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    tcp_options {
      max = 22
      min = 22
    }
  }
  # Define the egress rules
  egress {
    protocol = "all"
    source = "0.0.0.0/0"
    destination = "0.0.0.0/0"
  }
}

# Create a VMware Instance
resource "oci_vmware_instance" "main" {
  vcn_id = oci_core_vcn.main.id
  subnet_id = oci_core_subnet.main.id
  display_name = "my-vmware-instance"
  # Add any other relevant options here
  security_list_ids = [oci_core_security_list.main.id]
}

  