
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Replace with your tenancy OCID
  tenancy_ocid  = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your user OCID
  user_ocid     = "ocid1.user.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your region
  region         = "us-ashburn-1"
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Replace with your private key
  private_key_file = "~/.oci/oci_api_key.pem"
  # Replace with your fingerprint
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxx"
}

# Create a Virtual Cloud Network (VCN)
resource "oci_core_vcn" "main" {
  # Replace with a unique name for the VCN
  display_name = "my-vcn"
  cidr_block = "10.0.0.0/16"
}

# Create a subnet within the VCN
resource "oci_core_subnet" "main" {
  # Replace with a unique name for the subnet
  display_name = "my-subnet"
  vcn_id = oci_core_vcn.main.id
  cidr_block = "10.0.1.0/24"
}

# Create a security list to control network traffic
resource "oci_network_security_list" "main" {
  # Replace with a unique name for the security list
  display_name = "my-security-list"
  vcn_id = oci_core_vcn.main.id
  # Define ingress rules for the security list
  ingress {
    # Allow SSH traffic from anywhere
    protocol = "tcp"
    source = "0.0.0.0/0"
    destination_port_range = "22"
  }
}

# Create a route table associated with the VCN
resource "oci_core_route_table" "main" {
  # Replace with a unique name for the route table
  display_name = "my-route-table"
  vcn_id = oci_core_vcn.main.id
}

# Associate the subnet with the route table
resource "oci_core_subnet_route_table" "main" {
  # Replace with a unique name for the subnet route table
  display_name = "my-subnet-route-table"
  subnet_id = oci_core_subnet.main.id
  route_table_id = oci_core_route_table.main.id
}

  