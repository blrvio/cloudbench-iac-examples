
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Replace with your tenancy OCID, region and profile
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaw7g7b57c35v3yfqo"
  region       = "us-ashburn-1"
  profile      = "my-profile"
}

# Create a compliance document
resource "oci_compliance_document" "example" {
  # Replace with your desired compliance document details
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaw7g7b57c35v3yfqo"
  display_name  = "My Compliance Document"
  document_type = "CUSTOM"
  # Add the compliance document content
  content = <<EOF
# This is an example compliance document
# Replace with your desired content
EOF
}

  