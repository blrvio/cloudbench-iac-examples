
    # Configure the Oracle Cloud Infrastructure provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user    = "ocid1.user.oc1..aaaaaaaaxxxxxx"
  key     = "<your_api_key>" # Replace with your actual API key
}

# Create a Dynamic Routing Gateway
resource "oci_core_drg" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name  = "my-drg"
  # Set the location for the DRG
  location = "us-ashburn-1"
}

# Create a Virtual Cloud Network (VCN)
resource "oci_core_vcn" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name  = "my-vcn"
  # Set the CIDR block for the VCN
  cidr_block = "10.0.0.0/16"

  # Attach the VCN to the DRG
  drg_id = oci_core_drg.main.id
}

# Create a Route Table
resource "oci_core_route_table" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name  = "my-route-table"
  vcn_id        = oci_core_vcn.main.id

  # Define the route rules
  route_rules {  
    destination  = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    # Set the DRG attachment as the next hop
    next_hop  = oci_core_drg_attachment.main.id
  }
}

# Create a DRG attachment for the VCN
resource "oci_core_drg_attachment" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxx"
  display_name  = "my-drg-attachment"
  drg_id        = oci_core_drg.main.id
  vcn_id        = oci_core_vcn.main.id
}

  