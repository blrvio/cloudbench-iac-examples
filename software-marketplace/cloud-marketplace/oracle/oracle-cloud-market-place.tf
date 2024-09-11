
    # Configure the Oracle Cloud provider
provider "oci" {
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaab7g27j65m7q64h47yey4447y4w7d26l4h5"
}

# Create a resource group
resource "oci_resource_manager_resource_group" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaag6t23y4b7o4lzw6b6o2s66i6w7g32l75x"
  display_name  = "terraform-resource-group"
}

# Create an Oracle Cloud Market Place listing
resource "oci_marketplace_listing" "example" {
  compartment_id = oci_resource_manager_resource_group.example.id
  display_name = "Example Marketplace Listing"
  # ... Other configuration options
  # Use the data source for the listing ID
  listing_id = oci_marketplace_listing.example.listing_id
}

# Data source to get the listing ID
# This assumes you already have a listing in your Oracle Cloud Marketplace
data "oci_marketplace_listing" "example" {
  compartment_id = oci_resource_manager_resource_group.example.id
  display_name = "Example Marketplace Listing"
}

  