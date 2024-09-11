
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Replace with your region and tenancy
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..aaaaaaaaz4wtwjd6"
}

# Create a resource group
resource "oci_resource_manager_resource_group" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxw675n7b"
  display_name  = "my-resource-group"
}

# Create a policy to grant access to the resource group
resource "oci_resource_manager_policy" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxw675n7b"
  name           = "my-policy"
  statements = [
    {
      effect       = "allow"
      actions      = ["manage"]
      resources     = [oci_resource_manager_resource_group.main.id]
      principals   = ["ocid1.user.oc1..aaaaaaaaxw675n7b"] # Replace with your user OCID
    }
  ]
}
  