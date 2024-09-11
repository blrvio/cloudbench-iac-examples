
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaw7g5o462y"
  user    = "ocid1.user.oc1..aaaaaaaaxg5o4635"
  key     = "your_api_key"
}

# Create a resource group
resource "oci_resource_manager_resource_group" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaayg5o4639"
  display_name  = "example-resource-group"
  # Optional fields
  description = "Example Resource Group"
}

  